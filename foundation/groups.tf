resource "nsxt_policy_group" "dns_svc" {
  nsx_id       = "DNS_SVC"
  display_name = "DNS_SVC"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.dns_server]
    }
  }
}

resource "nsxt_policy_group" "ntp_svc" {
  nsx_id       = "NTP_SVC"
  display_name = "NTP_SVC"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.ntp_server]
    }
  }
}

resource "nsxt_policy_group" "dhcp_svc" {
  nsx_id       = "DHCP_SVC"
  display_name = "DHCP_SVC"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.dhcp_server]
    }
  }
}

resource "nsxt_policy_group" "vcfops_cp" {
  nsx_id       = "VCFOPS_CP"
  display_name = "VCFOPS_CP"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.vcfops_cp
    }
  }
}

resource "nsxt_policy_group" "vcf_a" {
  nsx_id       = "VCF_AUTOMATION"
  display_name = "VCF_AUTOMATION"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.vcfa
    }
  }
}

resource "nsxt_policy_group" "m01_vc" {
  nsx_id       = "M01_VC"
  display_name = "M01_VC"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.m01_vc01
    }
  }
}

resource "nsxt_policy_group" "m01_nsx" {
  nsx_id       = "M01_NSX"
  display_name = "M01_NSX"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.m01_nsx01a
    }
  }
}


resource "nsxt_policy_group" "m01_avi" {
  nsx_id       = "M01_AVI"
  display_name = "M01_AVI"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.m01_avi01
    }
  }
}

resource "nsxt_policy_group" "m01_hosts" {
  nsx_id       = "M01_HOSTS"
  display_name = "M01_HOSTS"
  group_type   = "IPAddress"

  tag {
    scope = "m01"
    tag   = "hosts"
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_hosts]
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_wld" {
  nsx_id       = "M01_SUP01_WLD"
  display_name = "M01_SUP01_WLD"

  criteria {
    condition {
      key         = "Tag"
      member_type = "SegmentPort"
      operator    = "EQUALS"
      value       = var.m01_sup01_wld_tag
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_mgmt" {
  nsx_id       = "M01_SUP01_MGMT"
  display_name = "M01_SUP01_MGMT"

  criteria {
    condition {
      key         = "Tag"
      member_type = "DVPort"
      operator    = "EQUALS"
      value       = var.m01_sup01_mgmt_vif_tag
    }
  }
}

resource "nsxt_policy_group" "m01_avi_se_snat" {
  nsx_id       = "M01_AVI_SE_SNAT"
  display_name = "M01_AVI_SE_SNAT"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_avi01_se_snat]
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_api" {
  nsx_id       = "M01_SUP01_API"
  display_name = "M01_SUP01_API"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_api]
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_image_proxy" {
  nsx_id       = "M01_SUP01_IMAGE_PROXY"
  display_name = "M01_SUP01_IMAGE_PROX"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_image_proxy]
    }
  }
}

resource "nsxt_policy_group" "ext_192_168_16_0_22" {
  nsx_id       = "EXT_192.168.16.0_22"
  display_name = "EXT_192.168.16.0_22"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.ext_192_168_16_0_22]
    }
  }
}

resource "nsxt_policy_group" "ext_192_168_4_0_22" {
  nsx_id       = "EXT_192.168.4.0_22"
  display_name = "EXT_192.168.4.0_22"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.ext_192_168_4_0_22]
    }
  }
}

resource "nsxt_policy_group" "cci_ns_controller_manager" {
  nsx_id       = "CCI_NS_CTL_MANAGER"
  display_name = "CCI_NS_CTL_MANAGER"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.cci_ns_controller_manager
    }
  }
}

resource "nsxt_policy_group" "configuration_service_controller_manager" {
  nsx_id       = "CFG_SVC_CTL_MANAGER"
  display_name = "CFG_SVC_CTL_MANAGER"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.configuration_service_controller_manager
    }
  }
}

resource "nsxt_policy_group" "alpha_vpc_prod_snat" {
  nsx_id       = "ALPHA_VPC_PROD_SNAT"
  display_name = "ALPHA_VPC_PROD_SNAT"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.alpha_vpc_prod_snat]
    }
  }
}

resource "nsxt_policy_group" "vpc_kube_system_snat" {
  nsx_id       = "VPC_KUBE_SYSTEM_SNAT"
  display_name = "VPC_KUBE_SYSTEM_SNAT"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.vpc_kube_system_snat]
    }
  }
}

resource "nsxt_policy_group" "auto_attach" {
  nsx_id       = "AUTO_ATTACH"
  display_name = "AUTO_ATTACH"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.auto_attach
    }
  }
}

resource "nsxt_policy_group" "metrics_aggregator" {
  nsx_id       = "METRICS_AGGR"
  display_name = "METRICS_AGGR"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.metrics_aggregator
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_kube_dns" {
  nsx_id       = "M01_SUP01_KUBE_DNS"
  display_name = "M01_SUP01_KUBE_DNS"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_kube_dns]
    }
  }
}

resource "nsxt_policy_group" "harbor" {
  nsx_id       = "HARBOR"
  display_name = "HARBOR"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.harbor
    }
  }
}

resource "nsxt_policy_group" "contour_envoy" {
  nsx_id       = "CONTOUR_ENVOY"
  display_name = "CONTOUR_ENVOY"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.contour_envoy
    }
  }
}

resource "nsxt_policy_group" "any_vks_cluster" {
  nsx_id       = "ANY_VKS_CLUSTER"
  display_name = "ANY_VKS_CLUSTER"

  criteria {
    condition {
      member_type = "SegmentPort"
      key         = "Tag"
      operator    = "EQUALS"
      value       = var.vks_cluster_tag
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_mgmt_proxy_lb" {
  nsx_id       = "M01_SUP01_MGMT_PROXY_LB"
  display_name = "M01_SUP01_MGMT_PROXY_LB"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_mgmt_proxy_lb]
    }
  }
}

resource "nsxt_policy_group" "metrics_aggregator_lb" {
  nsx_id       = "METRICS_AGGR_LB"
  display_name = "METRICS_AGGR_LB"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.metrics_aggregator_lb]
    }
  }
}