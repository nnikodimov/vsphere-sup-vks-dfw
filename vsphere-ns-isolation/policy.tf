resource "nsxt_policy_security_policy" "prod01_9lqzy_ns_policy" {
  display_name    = "prod01-9lqzy Namespace Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [nsxt_policy_group.prod01_9lqzy_ns.path]
  sequence_number = 1

  context {
    project_id = data.nsxt_policy_project.this.id
  }

  rule {
    display_name       = "Intra Namespace (IN/OUT)"
    source_groups      = [nsxt_policy_group.prod01_9lqzy_ns.path]
    destination_groups = [nsxt_policy_group.prod01_9lqzy_ns.path]
    action             = "ALLOW"
    direction          = "IN_OUT"
    logged             = false
  }

  rule {
    display_name  = "VPC LB SNAT Inbound (IN)"
    source_groups = [nsxt_policy_group.vpc_lb_snat.path]
    services = [
      data.nsxt_policy_service.https.path,
      nsxt_policy_service.tcp_6443.path,
      nsxt_policy_service.tcp_30000_32767.path,
      nsxt_policy_service.tcp_61000_62000.path,
    ]
    action    = "ALLOW"
    direction = "IN"
    logged    = false
  }

  rule {
    display_name = "Namespace Outbound (OUT)"
    action       = "ALLOW"
    direction    = "OUT"
    logged       = false
  }

  rule {
    display_name = "Namespace Lockdown (IN/OUT)"
    action       = "DROP"
    direction    = "IN_OUT"
    logged       = true
    log_label    = "prod01_9lqzy_ns"
  }
}
