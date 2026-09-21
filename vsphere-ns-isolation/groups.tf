resource "nsxt_policy_group" "prod01_9lqzy_ns" {
  nsx_id       = "PROD01_9LQZY_NS"
  display_name = "prod01-9lqzy"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "SegmentPort"
      operator    = "EQUALS"
      value       = var.ns_tag
    }
  }
}

resource "nsxt_policy_group" "vpc_lb_snat" {
  nsx_id       = "VPC_LB_SNAT"
  display_name = "vpc-lb-snat"
  group_type   = "IPAddress"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [var.vpc_lb_snat_cidr]
    }
  }
}
