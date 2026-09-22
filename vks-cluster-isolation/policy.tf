resource "nsxt_policy_security_policy" "vks01_cluster_policy" {
  display_name    = "vks01-cluster Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [nsxt_policy_group.vks01_segment.path]
  sequence_number = 11

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  rule {
    display_name       = "Intra Cluster (IN/OUT)"
    source_groups      = [nsxt_policy_group.vks01_segment.path]
    destination_groups = [nsxt_policy_group.vks01_segment.path]
    action             = "ALLOW"
    direction          = "IN_OUT"
    logged             = false
  }

  rule {
    display_name  = "VPC LB SNAT Inbound (IN)"
    source_groups = [nsxt_policy_group.vpc_lb_snat.path]
    services = [
      nsxt_policy_service.tcp_30000_32767.path,
      nsxt_policy_service.tcp_61000_62000.path,
    ]
    action    = "ALLOW"
    direction = "IN"
    logged    = false
  }

  rule {
    display_name = "Cluster Outbound (OUT)"
    action       = "ALLOW"
    direction    = "OUT"
    logged       = false
  }

  rule {
    display_name = "Cluster Lockdown (IN/OUT)"
    action       = "DROP"
    direction    = "IN_OUT"
    logged       = true
    log_label    = "vks01_cluster"
  }
}
