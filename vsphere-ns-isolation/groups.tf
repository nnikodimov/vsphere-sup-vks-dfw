data "nsxt_policy_project" "this" {
  display_name = var.nsx_project_name
}

resource "nsxt_policy_group" "prod01_9lqzy_ns" {
  nsx_id       = "PROD01_9LQZY_NS"
  display_name = "prod01-9lqzy"

  context {
    project_id = data.nsxt_policy_project.this.id
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

  context {
    project_id = data.nsxt_policy_project.this.id
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [var.vpc_lb_snat_cidr]
    }
  }
}
