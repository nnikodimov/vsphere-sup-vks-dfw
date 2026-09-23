locals {
  groups   = var.groups
  services = var.services
}

resource "nsxt_policy_security_policy" "vks_policy" {
  display_name    = "VKS Clusters Control Plane Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [local.groups["any_vks_cluster"]]
  sequence_number = 6

  rule {
    display_name       = "VKS Management HTTPS (OUT)"
    destination_groups = [local.groups["vcf_a"], local.groups["m01_avi"], local.groups["m01_sup01_api"], local.groups["m01_sup01_image_proxy"]]
    services           = [local.services["https"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Supervisor Management Proxy (OUT)"
    destination_groups = [local.groups["m01_sup01_mgmt_proxy_lb"]]
    services           = [local.services["tcp_10091_10092"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name       = "Metrics Aggregator Service (OUT)"
    destination_groups = [local.groups["metrics_aggregator_lb"]]
    services           = [local.services["tcp_10093"]]
    action             = "ALLOW"
    direction          = "OUT"
    logged             = false
  }

  rule {
    display_name = "Kubernetes API (IN/OUT)"
    services     = [local.services["tcp_6443"]]
    action       = "ALLOW"
    direction    = "IN_OUT"
    logged       = false
  }
}
