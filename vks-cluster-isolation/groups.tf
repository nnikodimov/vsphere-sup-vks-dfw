resource "nsxt_policy_group" "vks01_segment" {
  nsx_id       = "VKS01_SEGMENT"
  display_name = "vks01-cluster"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  criteria {
    condition {
      key         = "Tag"
      member_type = "Segment"
      operator    = "EQUALS"
      value       = var.segment_tag
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
