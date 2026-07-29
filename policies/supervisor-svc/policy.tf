locals {
  groups   = data.terraform_remote_state.foundation.outputs.group_paths
  services = data.terraform_remote_state.foundation.outputs.service_paths
}

resource "nsxt_policy_security_policy" "m01_sup01_svc_policy" {
  display_name    = "Supervisor Services Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  sequence_number = 3

  rule {
    display_name       = "Auto-Attach Service DNS (OUT)"
    destination_groups = [local.groups["m01_sup01_kube_dns"]]
    services           = [local.services["dns_udp"], local.services["dns_tcp"]]
    action             = "ALLOW"
    scope              = [local.groups["auto_attach"], local.groups["cci_ns_controller_manager"], local.groups["configuration_service_controller_manager"], local.groups["metrics_aggregator"]]
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Auto-Attach Service HTTPS (OUT)"
    destination_groups = [local.groups["vcf_a"]]
    services           = [local.services["https"]]
    action             = "ALLOW"
    scope              = [local.groups["auto_attach"]]
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Auto-Attach and Configuration Service K8s API (OUT)"
    destination_groups = [local.groups["ext_192_168_4_0_22"], local.groups["ext_192_168_16_0_22"]]
    services           = [local.services["tcp_6443"]]
    action             = "ALLOW"
    scope              = [local.groups["auto_attach"], local.groups["configuration_service_controller_manager"]]
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name  = "Cloud Consumption Interface Service (IN)"
    source_groups = [local.groups["vpc_kube_system_snat"]]
    services      = [local.services["tcp_8053"]]
    action        = "ALLOW"
    scope         = [local.groups["cci_ns_controller_manager"]]
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name  = "Configuration Service (IN)"
    source_groups = [local.groups["vpc_kube_system_snat"]]
    services      = [local.services["tcp_9443"]]
    action        = "ALLOW"
    scope         = [local.groups["configuration_service_controller_manager"]]
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name  = "Metrics Aggregator Service (IN)"
    source_groups = [local.groups["m01_avi_se_snat"]]
    services      = [local.services["tcp_10093"]]
    action        = "ALLOW"
    scope         = [local.groups["metrics_aggregator"]]
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name = "Supervisor Services Lockdown (IN/OUT)"
    action       = "DROP"
    scope        = [local.groups["auto_attach"], local.groups["cci_ns_controller_manager"], local.groups["configuration_service_controller_manager"], local.groups["metrics_aggregator"]]
    direction    = "IN_OUT"
    logged       = true
    log_label    = "m01_sup01_svc"
  }
}
