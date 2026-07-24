resource "nsxt_policy_security_policy" "m01_sup01_mgmt_policy" {
  display_name         = "Sypervisor Management Policy"
  category             = "Environment"
  locked               = false
  stateful             = true
  tcp_strict           = true
  sequence_number      = 1

  rule {
    display_name       = "Supervisor DNS (OUT)"
    destination_groups = [nsxt_policy_group.dns_svc.path]
    services           = [data.nsxt_policy_service.dns_udp.path,data.nsxt_policy_service.dns_tcp.path]
	profiles           = [data.nsxt_policy_context_profile.cxt_dns.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor NTP (OUT)"
    destination_groups = [nsxt_policy_group.ntp_svc.path]
    services           = [data.nsxt_policy_service.ntp.path]
    action             = "ALLOW"
    scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Broadcom Internet repos (OUT)"
    services           = [data.nsxt_policy_service.https.path]
    profiles           = [nsxt_policy_context_profile.internet_fqdns.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
    direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "VCF Management (OUT)"
    destination_groups = [nsxt_policy_group.m01_vc.path,nsxt_policy_group.m01_nsx.path,nsxt_policy_group.m01_avi.path,nsxt_policy_group.vcf_a.path,nsxt_policy_group.vcfops_cp.path]
    services           = [data.nsxt_policy_service.https.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "NSX Manager (OUT)"
    destination_groups = [nsxt_policy_group.m01_nsx.path]
    services           = [nsxt_policy_service.tcp_1234_1235.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "vCenter Server (IN)"
    source_groups      = [nsxt_policy_group.m01_vc.path]
    services           = [data.nsxt_policy_service.https.path,data.nsxt_policy_service.ssh.path,nsxt_policy_service.tcp_6443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "VCF Automation (IN)"
    source_groups      = [nsxt_policy_group.vcf_a.path]
    services           = [data.nsxt_policy_service.https.path,nsxt_policy_service.tcp_6443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "ESX hosts (OUT)"
    destination_groups = [nsxt_policy_group.m01_hosts.path]
    services           = [nsxt_policy_service.tcp_10250.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "ESX hosts (IN)"
    source_groups      = [nsxt_policy_group.m01_hosts.path]
    services           = [nsxt_policy_service.tcp_6443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor Management Lockdown (IN/OUT)"
    action             = "DROP"
	scope              = [nsxt_policy_group.m01_sup01_mgmt.path]
	direction          = "IN_OUT"
    logged             = true
	log_label          = "m01_sup01_mgmt"
  }
}

resource "nsxt_policy_security_policy" "m01_sup01_wld_policy" {
  display_name         = "Supervisor Workload Policy"
  category             = "Environment"
  locked               = false
  stateful             = true
  tcp_strict           = true
  sequence_number      = 2

  rule {
    display_name       = "Supervisor Infra Services (IN)"
    source_groups      = [nsxt_policy_group.m01_avi_se_snat.path]
    services           = [data.nsxt_policy_service.dns_udp.path,data.nsxt_policy_service.dns_tcp.path,data.nsxt_policy_service.https.path,nsxt_policy_service.tcp_5000_6443_10091_10093.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor Services (IN)"
    source_groups      = [nsxt_policy_group.alpha_vpc_prod_snat.path]
    services           = [nsxt_policy_service.tcp_6443.path,nsxt_policy_service.tcp_10091_10092.path,nsxt_policy_service.tcp_10093.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor and Image Proxy LB Services (Out)"
    destination_groups = [nsxt_policy_group.m01_sup01_api.path,nsxt_policy_group.m01_sup01_image_proxy.path]
    services           = [data.nsxt_policy_service.https.path,data.nsxt_policy_service.http.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor K8s API (OUT)"
    destination_groups = [nsxt_policy_group.ext_192_168_16_0_22.path]
    services           = [nsxt_policy_service.tcp_6443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Cloud Consumption Interface (OUT)"
    destination_groups = [nsxt_policy_group.cci-ns-controller-manager.path]
    services           = [nsxt_policy_service.tcp_8053.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Configuration Orchestration (OUT)"
    destination_groups = [nsxt_policy_group.configuration-service-controller-manager.path]
    services           = [nsxt_policy_service.tcp_9443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor Workload Lockdown (IN/OUT)"
    action             = "DROP"
	scope              = [nsxt_policy_group.m01_sup01_wld.path]
	direction          = "IN_OUT"
    logged             = true
	log_label          = "m01_sup01_wld"
  }
}

resource "nsxt_policy_security_policy" "m01_sup01_svc_policy" {
  display_name         = "Supervisor Services Policy"
  category             = "Environment"
  locked               = false
  stateful             = true
  tcp_strict           = true
  sequence_number      = 3

  rule {
    display_name       = "Auto-Attach Service DNS (OUT)"
    destination_groups = [nsxt_policy_group.m01_sup01_kube_dns.path]
    services           = [data.nsxt_policy_service.dns_udp.path,data.nsxt_policy_service.dns_tcp.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.auto-attach.path]	
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Auto-Attach Service HTTPS (OUT)"
    destination_groups = [nsxt_policy_group.vcf_a.path]
    services           = [data.nsxt_policy_service.https.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.auto-attach.path]
	direction          = "OUT"
    logged             = false
  }	
  
  rule {
    display_name       = "Auto-Attach and Configuration Service K8s API (OUT)"
    destination_groups = [nsxt_policy_group.ext_192_168_4_0_22.path,nsxt_policy_group.ext_192_168_16_0_22.path]
    services           = [nsxt_policy_service.tcp_6443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.auto-attach.path,nsxt_policy_group.configuration-service-controller-manager.path]	
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Configuration Service (IN)"
    source_groups      = [nsxt_policy_group.vpc_kube_system_snat.path]
    services           = [nsxt_policy_service.tcp_9443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.configuration-service-controller-manager.path]	
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Cloud Consumption Interface Service (IN)"
    source_groups      = [nsxt_policy_group.vpc_kube_system_snat.path]
    services           = [nsxt_policy_service.tcp_8053.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.cci-ns-controller-manager.path]	
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Metrics Aggregator Service (IN)"
    source_groups      = [nsxt_policy_group.m01_avi_se_snat.path]
    services           = [nsxt_policy_service.tcp_10093.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.metrics-aggregator.path]	
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Supervisor Services Lockdown (IN/OUT)"
    action             = "DROP"
    scope              = [nsxt_policy_group.auto-attach.path,nsxt_policy_group.cci-ns-controller-manager.path,nsxt_policy_group.configuration-service-controller-manager.path,nsxt_policy_group.metrics-aggregator.path]
	direction          = "IN_OUT"
    logged             = true
	log_label          = "m01_sup01_svc"
  }
}

resource "nsxt_policy_security_policy" "harbor_svc_policy" {
  display_name         = "Supervisor Harbor Service Policy"
  category             = "Environment"
  locked               = false
  stateful             = true
  tcp_strict           = true
  sequence_number      = 4

  rule {
    display_name       = "Harbor DNS (OUT)"
    destination_groups = [nsxt_policy_group.m01_sup01_kube_dns.path]
    services           = [data.nsxt_policy_service.dns_udp.path,data.nsxt_policy_service.dns_tcp.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.harbor.path]	
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Harbor Portal (IN)"
    source_groups      = [nsxt_policy_group.contour_envoy.path]
    services           = [nsxt_policy_service.tcp_8443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.harbor.path]	
	direction          = "IN"
    logged             = false
  }
  
  rule {
    display_name       = "Harbor Intra-Nodes (IN/OUT)"
    source_groups      = [nsxt_policy_group.harbor.path]
	destination_groups = [nsxt_policy_group.harbor.path]
    services           = [nsxt_policy_service.tcp_5443.path,nsxt_policy_service.tcp_5432.path,nsxt_policy_service.tcp_6379.path,nsxt_policy_service.tcp_8443.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.harbor.path]	
	direction          = "IN_OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Harbor Registries (OUT)"
    services           = [data.nsxt_policy_service.https.path]
    action             = "ALLOW"
	scope              = [nsxt_policy_group.harbor.path]	
	direction          = "OUT"
    logged             = false
  }
  
  rule {
    display_name       = "Harbor Lockdown"
    action             = "DROP"
    scope              = [nsxt_policy_group.harbor.path]
	direction          = "IN_OUT"
    logged             = true
	log_label          = "harbor_svc"
  }
}