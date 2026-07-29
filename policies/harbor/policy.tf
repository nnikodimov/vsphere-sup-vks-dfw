locals {
  groups   = data.terraform_remote_state.foundation.outputs.group_paths
  services = data.terraform_remote_state.foundation.outputs.service_paths
}

resource "nsxt_policy_security_policy" "harbor_svc_policy" {
  display_name    = "Supervisor Harbor Service Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [local.groups["harbor"]]
  sequence_number = 5

  rule {
    display_name       = "Harbor DNS (OUT)"
    destination_groups = [local.groups["m01_sup01_kube_dns"]]
    services           = [local.services["dns_udp"], local.services["dns_tcp"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name  = "Harbor Portal (IN)"
    source_groups = [local.groups["contour_envoy"]]
    services      = [local.services["tcp_8443"]]
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name = "Harbor Registries (OUT)"
    services     = [local.services["https"]]
    action       = "ALLOW"
    direction    = "OUT"
    logged       = false
  }

  rule {
    display_name       = "Harbor Intra-Nodes (IN/OUT)"
    source_groups      = [local.groups["harbor"]]
    destination_groups = [local.groups["harbor"]]
    services           = [local.services["tcp_5443"], local.services["tcp_5432"], local.services["tcp_6379"], local.services["tcp_8443"]]
    action             = "ALLOW"
    direction          = "IN_OUT"
    logged             = false
  }

  rule {
    display_name = "Harbor Lockdown (IN/OUT)"
    action       = "DROP"
    direction    = "IN_OUT"
    logged       = true
    log_label    = "harbor_svc"
  }
}
