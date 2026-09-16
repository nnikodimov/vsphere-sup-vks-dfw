# vsphere-sup-vks-dfw

vDefend Distributed Firewall configuration for a vSphere Supervisor + VKS
environment. A single root module wires each layer in as a child module, so
they share one state file but can still be planned/applied individually with
`-target`.

## Prerequisites

- Terraform >= 1.6
- `vmware/nsxt` provider (installed automatically by `terraform init`)
- Network access from wherever you run Terraform to the NSX Manager in
  `terraform.tfvars` (`nsx_manager`)
- An NSX Manager account with permission to manage Policy groups, services,
  context profiles, and distributed firewall security policies

## Layout

```
main.tf               provider/backend configuration
variables.tf           all input variables
terraform.tfvars       committed, non-secret values
modules.tf              wires the modules below together
foundation/             groups, services, context profiles (shared building blocks)
policies/
  infrastructure/     DNS/NTP/DHCP allow rules, unscoped (applies firewall-wide)
  supervisor-mgmt/    locks down the Supervisor management network
  supervisor-wld/     locks down the Supervisor workload network
  supervisor-svc/     locks down auto-attach/CCI/configuration/metrics services
  harbor/             locks down the Harbor registry nodes
  vks/                locks down VKS cluster control-plane traffic
```

Each directory under `foundation/` and `policies/` is a child module with no
provider or backend configuration of its own — those live only in the root
`main.tf`. The `policies/*` modules take the groups/services/context-profiles
they need as input variables (`groups`, `services`, `profiles`), wired in
`modules.tf` from `module.foundation`'s outputs, rather than reading them via
a `terraform_remote_state` data source.

`infrastructure` has no `scope`, so its DNS/NTP/DHCP allow rules apply to
every group protected by any of the other policies. Its `sequence_number` (1)
is lower than every other policy's, so it's evaluated first within the
`Environment` category — this matters because the other policies each end in
a DROP-all lockdown rule scoped to their own group, which would otherwise
shadow the DNS/NTP/DHCP allows. Apply `infrastructure` before (or alongside)
the other policies for the first time; skipping it leaves DNS/NTP/DHCP
unreachable for any group with a lockdown rule already in place.

Every variable is documented in `variables.tf` (root) — see there for what
each group/service identifier represents.

## Credentials

NSX credentials (`nsx_username`, `nsx_password`) are kept out of version
control, at the repo root:

- `terraform.tfvars` — committed, non-secret values (`nsx_manager`,
  group/service identifiers)
- `secrets.auto.tfvars.example` — committed template for credentials
- `secrets.auto.tfvars` — gitignored; copy the example and fill in real
  values before running Terraform

```
cp secrets.auto.tfvars.example secrets.auto.tfvars
# edit secrets.auto.tfvars with the real NSX username/password
```

Terraform loads `*.auto.tfvars` files automatically, so no extra flags are
needed. `nsx_password` is declared `sensitive = true`, but it's still a
plaintext credential once written to `secrets.auto.tfvars` and to state —
treat both as secrets (file permissions, not sharing the state file, etc.).

## Usage

Initialize once at the repo root:

```
terraform init
```

Apply everything:

```
terraform apply
```

Or target a single layer by its module name — `foundation` must exist before
any `policies/*` module, since they all depend on its outputs:

```
terraform apply -target=module.foundation
terraform apply -target=module.infrastructure
terraform apply -target=module.supervisor-mgmt
terraform apply -target=module.supervisor-wld
terraform apply -target=module.supervisor-svc
terraform apply -target=module.harbor
terraform apply -target=module.vks
```

`-target` still evaluates the whole configuration graph, so it will pull in
`module.foundation` automatically when needed — but Terraform's plan output
for a targeted apply only reflects that module's resources, not the full
plan, so treat `-target` as an exception for touching one layer rather than
the routine way to apply.

Because all layers now share one state file, there's no per-layer state
isolation: a lock on the state file blocks concurrent applies of any two
layers, and state corruption would affect all of them. If you need layers
that can never affect each other's state, keep them as separate root
modules instead.

## Migrating existing per-layer state

If you have existing `terraform.tfstate` files from the previous
one-directory-per-layer layout (in `foundation/`, `policies/infrastructure/`,
etc.), moving to this module layout does **not** change any real NSX
resources by itself — but the state has to be migrated into the new shared
state file first, or Terraform will plan to destroy and recreate everything.

For each layer directory `<dir>` with an existing `terraform.tfstate`, from
the repo root (after `terraform init`), list its resources and move each one
into the corresponding module address:

```
terraform state list -state=<dir>/terraform.tfstate
terraform state mv -state=<dir>/terraform.tfstate -state-out=terraform.tfstate '<address>' 'module.<module-name>.<address>'
```

e.g. for `foundation/terraform.tfstate`:

```
terraform state mv -state=foundation/terraform.tfstate -state-out=terraform.tfstate \
  'nsxt_policy_group.dns_svc' 'module.foundation.nsxt_policy_group.dns_svc'
```

Repeat for every address `terraform state list` prints for that layer,
against every old state file you have, then run `terraform plan` and confirm
it reports no changes for the already-deployed layers before applying
anything.
