locals {
  groups   = data.terraform_remote_state.foundation.outputs.group_paths
  services = data.terraform_remote_state.foundation.outputs.service_paths
  profiles = data.terraform_remote_state.foundation.outputs.context_profile_paths
}

resource "nsxt_policy_security_policy" "m01_sup01_mgmt_policy" {
  display_name    = "Supervisor Management Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [local.groups["m01_sup01_mgmt"]]
  sequence_number = 1

  rule {
    display_name       = "Supervisor DNS (OUT)"
    destination_groups = [local.groups["dns_svc"]]
    services           = [local.services["dns_udp"], local.services["dns_tcp"]]
    profiles           = [local.profiles["cxt_dns"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Supervisor NTP (OUT)"
    destination_groups = [local.groups["ntp_svc"]]
    services           = [local.services["ntp"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Supervisor DHCP (OUT)"
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

  rule {
    display_name       = "VCF Management (OUT)"
    destination_groups = [local.groups["m01_vc"], local.groups["m01_nsx"], local.groups["m01_avi"], local.groups["vcf_a"], local.groups["vcfops_cp"]]
    services           = [local.services["https"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "NSX Manager (OUT)"
    destination_groups = [local.groups["m01_nsx"]]
    services           = [local.services["tcp_1234_1235"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name  = "vCenter Server (IN)"
    source_groups = [local.groups["m01_vc"]]
    services      = [local.services["https"], local.services["ssh"], local.services["tcp_6443"]]
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name  = "VCF Automation (IN)"
    source_groups = [local.groups["vcf_a"]]
    services      = [local.services["https"], local.services["tcp_6443"]]
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name       = "ESX hosts (OUT)"
    destination_groups = [local.groups["m01_hosts"]]
    services           = [local.services["tcp_10250"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name  = "ESX hosts (IN)"
    source_groups = [local.groups["m01_hosts"]]
    services      = [local.services["tcp_6443"]]
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name = "Supervisor Management Lockdown (IN/OUT)"
    action       = "DROP"
    direction    = "IN_OUT"
    logged       = true
    log_label    = "m01_sup01_mgmt"
  }
}
