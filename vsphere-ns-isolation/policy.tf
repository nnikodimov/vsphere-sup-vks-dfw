data "nsxt_policy_group" "alpha_default" {
  display_name = "PROJECT-${var.alpha_project_id}-default"

  context {
    project_id = var.alpha_project_id
  }
}

resource "nsxt_policy_security_policy" "prod01_9lqzy_ns_policy" {
  display_name    = "Prod01-9lqzy Namespace Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [nsxt_policy_group.prod01_9lqzy_ns.path]
  sequence_number = 10

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
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
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name  = "Namespace Lockdown (IN)"
    source_groups = [data.nsxt_policy_group.alpha_default.path]
    action        = "DROP"
    direction     = "IN"
    logged        = true
  }
}

resource "nsxt_policy_security_policy" "dev01_h28ct_ns_policy" {
  display_name    = "Dev01-h28ct Namespace Policy"
  category        = "Environment"
  locked          = false
  stateful        = true
  tcp_strict      = true
  scope           = [nsxt_policy_group.dev01_h28ct_ns.path]
  sequence_number = 11

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  rule {
    display_name       = "Intra Namespace (IN/OUT)"
    source_groups      = [nsxt_policy_group.dev01_h28ct_ns.path]
    destination_groups = [nsxt_policy_group.dev01_h28ct_ns.path]
    action             = "ALLOW"
    direction          = "IN_OUT"
    logged             = false
  }

  rule {
    display_name  = "VPC LB SNAT Inbound (IN)"
    source_groups = [nsxt_policy_group.vpc_lb_snat.path]
    action        = "ALLOW"
    direction     = "IN"
    logged        = false
  }

  rule {
    display_name  = "Namespace Lockdown (IN)"
    source_groups = [data.nsxt_policy_group.alpha_default.path]
    action        = "DROP"
    direction     = "IN"
    logged        = true
  }
}
