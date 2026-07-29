# vsphere-sup-vks-dfw

vDefend Distributed Firewall configuration for a vSphere Supervisor + VKS
environment, split into independent Terraform layers so each layer has its
own state file and can be applied on its own.

## Prerequisites

- Terraform >= 1.6
- `vmware/nsxt` provider (installed automatically by `terraform init`)
- Network access from wherever you run Terraform to the NSX Manager in
  `terraform.tfvars` (`nsx_manager`)
- An NSX Manager account with permission to manage Policy groups, services,
  context profiles, and distributed firewall security policies

## Layout

```
foundation/           groups, services, context profiles (shared building blocks)
policies/
  infrastructure/     DNS/NTP/DHCP allow rules, unscoped (applies firewall-wide)
  supervisor-mgmt/    locks down the Supervisor management network
  supervisor-wld/     locks down the Supervisor workload network
  supervisor-svc/     locks down auto-attach/CCI/configuration/metrics services
  harbor/             locks down the Harbor registry nodes
  vks/                locks down VKS cluster control-plane traffic
```

Each directory is its own root module with its own local state file
(`terraform.tfstate` in that directory). The `policies/*` layers read the
groups/services/context-profiles they need from the `foundation` layer via a
`terraform_remote_state` data source — they never reference `foundation`'s
resources directly, so they can be planned/applied independently as long as
`foundation` has been applied at least once.

`infrastructure` has no `scope`, so its DNS/NTP/DHCP allow rules apply to
every group protected by any of the other policies. Its `sequence_number` (1)
is lower than every other policy's, so it's evaluated first within the
`Environment` category — this matters because the other policies each end in
a DROP-all lockdown rule scoped to their own group, which would otherwise
shadow the DNS/NTP/DHCP allows. Apply `infrastructure` before (or alongside)
the other policies for the first time; skipping it leaves DNS/NTP/DHCP
unreachable for any group with a lockdown rule already in place.

Every variable is documented in that layer's `variables.tf` — see there for
what each group/service identifier represents.

## Credentials

NSX credentials (`nsx_username`, `nsx_password`) are kept out of version
control. Each layer directory has:

- `terraform.tfvars` — committed, non-secret values (e.g. `nsx_manager`,
  group/service identifiers)
- `secrets.auto.tfvars.example` — committed template for credentials
- `secrets.auto.tfvars` — gitignored; copy the example and fill in real
  values before running Terraform in that directory

```
cd foundation
cp secrets.auto.tfvars.example secrets.auto.tfvars
# edit secrets.auto.tfvars with the real NSX username/password
```

Repeat for each `policies/*` directory you plan to apply. Terraform loads
`*.auto.tfvars` files automatically, so no extra flags are needed.

`nsx_password` is declared `sensitive = true`, but it's still a plaintext
credential once written to `secrets.auto.tfvars` and to local state — treat
both as secrets (file permissions, not sharing state files, etc.).

## Usage

Apply the foundation layer first (or after any group/service change):

```
cd foundation
terraform init
terraform apply
```

Apply the infrastructure policy next (see the note above on why it goes
before the others), then any DFW policy independently, e.g. just the
Supervisor Management policy:

```
cd policies/infrastructure
terraform init
terraform apply

cd ../supervisor-mgmt
terraform init
terraform apply
```

Repeat for `policies/supervisor-wld`, `policies/supervisor-svc`,
`policies/harbor`, `policies/vks` as needed — each is a separate
`terraform apply` with its own plan/state, so changing one policy never
touches the others.
