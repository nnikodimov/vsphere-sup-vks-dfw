resource "nsxt_policy_group" "dns_svc" {
  nsx_id       = "DNS_SVC"
  display_name = "dns-svc"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.dns_server]
    }
  }
}

resource "nsxt_policy_group" "ntp_svc" {
  nsx_id       = "NTP_SVC"
  display_name = "ntp-svc"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.ntp_server]
    }
  }
}

resource "nsxt_policy_group" "dhcp_svc" {
  nsx_id       = "DHCP_SVC"
  display_name = "dhcp-svc"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.dhcp_server]
    }
  }
}

resource "nsxt_policy_group" "vcfops_cp" {
  nsx_id       = "VCFOPS_CP"
  display_name = "vcfops-cp"

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
  display_name = "vcf-automation"

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
  display_name = "m01-vc"

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
  display_name = "m01-nsx"

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
  display_name = "m01-avi"

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
  display_name = "m01-hosts"
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
  display_name = "m01-sup01-wld"

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
  display_name = "m01-sup01-mgmt"

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
  display_name = "m01-avi-se-snat"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_avi01_se_snat]
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_api" {
  nsx_id       = "M01_SUP01_API"
  display_name = "m01-sup01-api"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_api]
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_image_proxy" {
  nsx_id       = "M01_SUP01_IMAGE_PROXY"
  display_name = "m01-sup01-image-prox"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_image_proxy]
    }
  }
}

resource "nsxt_policy_group" "ext_192_168_16_0_22" {
  nsx_id       = "EXT_192.168.16.0_22"
  display_name = "ext-192.168.16.0-22"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.ext_192_168_16_0_22]
    }
  }
}

resource "nsxt_policy_group" "ext_192_168_4_0_22" {
  nsx_id       = "EXT_192.168.4.0_22"
  display_name = "ext-192.168.4.0-22"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.ext_192_168_4_0_22]
    }
  }
}

resource "nsxt_policy_group" "cci_ns_controller_manager" {
  nsx_id       = "CCI_NS_CTL_MANAGER"
  display_name = "cci-ns-ctl-manager"

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
  display_name = "cfg-svc-ctl-manager"

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
  display_name = "alpha-vpc-prod-snat"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.alpha_vpc_prod_snat]
    }
  }
}

resource "nsxt_policy_group" "vpc_kube_system_snat" {
  nsx_id       = "VPC_KUBE_SYSTEM_SNAT"
  display_name = "vpc-kube-system-snat"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.vpc_kube_system_snat]
    }
  }
}

resource "nsxt_policy_group" "auto_attach" {
  nsx_id       = "AUTO_ATTACH"
  display_name = "auto-attach"

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
  display_name = "metrics-aggr"

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
  display_name = "m01-sup01-kube-dns"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_kube_dns]
    }
  }
}

resource "nsxt_policy_group" "harbor" {
  nsx_id       = "HARBOR"
  display_name = "harbor"

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
  display_name = "contour-envoy"

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
  display_name = "any-vks-cluster"

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
  display_name = "m01-sup01-mgmt-proxy-lb"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.m01_sup01_mgmt_proxy_lb]
    }
  }
}

resource "nsxt_policy_group" "metrics_aggregator_lb" {
  nsx_id       = "METRICS_AGGR_LB"
  display_name = "metrics-aggr-lb"
  group_type   = "IPAddress"

  criteria {
    ipaddress_expression {
      ip_addresses = [var.metrics_aggregator_lb]
    }
  }
}