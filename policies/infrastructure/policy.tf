locals {
  groups   = data.terraform_remote_state.foundation.outputs.group_paths
  services = data.terraform_remote_state.foundation.outputs.service_paths
  profiles = data.terraform_remote_state.foundation.outputs.context_profile_paths
}

resource "nsxt_policy_security_policy" "infrastructure_policy" {
  display_name    = "Infrastructure Services Policy"
  category        = "Infrastructure"
  locked          = false
  stateful        = true
  tcp_strict      = true
  sequence_number = 1

  rule {
    display_name       = "DNS (OUT)"
    destination_groups = [local.groups["dns_svc"]]
    services           = [local.services["dns_udp"], local.services["dns_tcp"]]
    profiles           = [local.profiles["cxt_dns"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "NTP (OUT)"
    destination_groups = [local.groups["ntp_svc"]]
    services           = [local.services["ntp"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "DHCP (OUT)"
    destination_groups = [local.groups["dhcp_svc"]]
    services           = [local.services["dhcp_server"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name = "Broadcom Internet repos (OUT)"
    services     = [local.services["https"]]
    profiles     = [local.profiles["internet_fqdns"]]
    action       = "ALLOW"
    direction    = "OUT"
    logged       = false
  }
}
