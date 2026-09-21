locals {
  groups   = var.groups
  services = var.services
}

resource "nsxt_policy_security_policy" "m01_sup01_wld_policy" {
  display_name    = "Supervisor Workload Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [local.groups["m01_sup01_wld"]]
  sequence_number = 3

  rule {
    display_name  = "Supervisor Infra Services (IN)"
    source_groups = [local.groups["m01_avi_se_snat"]]
    services      = [local.services["dns_udp"], local.services["dns_tcp"], local.services["https"], local.services["tcp_5000_6443_10091_10093"]]
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name       = "Supervisor and Image Proxy LB Services (Out)"
    destination_groups = [local.groups["m01_sup01_api"], local.groups["m01_sup01_image_proxy"]]
    services           = [local.services["https"], local.services["http"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Supervisor K8s API (OUT)"
    destination_groups = [local.groups["ext_192_168_16_0_22"]]
    services           = [local.services["tcp_6443"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Cloud Consumption Interface (OUT)"
    destination_groups = [local.groups["cci_ns_controller_manager"]]
    services           = [local.services["tcp_8053"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Configuration Orchestration (OUT)"
    destination_groups = [local.groups["configuration_service_controller_manager"]]
    services           = [local.services["tcp_9443"], local.services["tcp_8081"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Supervisor workload Intra (IN/OUT)"
    source_groups      = [local.groups["m01_sup01_wld"]]
    destination_groups = [local.groups["m01_sup01_wld"]]
    action             = "ALLOW"
    direction          = "IN_OUT"
    logged             = false
  }

  rule {
    display_name = "Supervisor Workload Lockdown (IN/OUT)"
    action       = "DROP"
    direction    = "IN_OUT"
    logged       = true
    log_label    = "m01_sup01_wld"
  }
}
