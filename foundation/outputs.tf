output "group_paths" {
  description = "Map of NSX policy group name to path, consumed by the policy modules as module input variables."
  value = {
    dns_svc                                  = nsxt_policy_group.dns_svc.path
    ntp_svc                                  = nsxt_policy_group.ntp_svc.path
    dhcp_svc                                 = nsxt_policy_group.dhcp_svc.path
    vcfops_cp                                = nsxt_policy_group.vcfops_cp.path
    vcf_a                                    = nsxt_policy_group.vcf_a.path
    m01_vc                                   = nsxt_policy_group.m01_vc.path
    m01_nsx                                  = nsxt_policy_group.m01_nsx.path
    m01_avi                                  = nsxt_policy_group.m01_avi.path
    m01_hosts                                = nsxt_policy_group.m01_hosts.path
    m01_sup01_wld                            = nsxt_policy_group.m01_sup01_wld.path
    m01_sup01_mgmt                           = nsxt_policy_group.m01_sup01_mgmt.path
    m01_avi_se_snat                          = nsxt_policy_group.m01_avi_se_snat.path
    m01_sup01_api                            = nsxt_policy_group.m01_sup01_api.path
    m01_sup01_image_proxy                    = nsxt_policy_group.m01_sup01_image_proxy.path
    ext_192_168_16_0_22                      = nsxt_policy_group.ext_192_168_16_0_22.path
    ext_192_168_4_0_22                       = nsxt_policy_group.ext_192_168_4_0_22.path
    cci_ns_controller_manager                = nsxt_policy_group.cci_ns_controller_manager.path
    configuration_service_controller_manager = nsxt_policy_group.configuration_service_controller_manager.path
    alpha_vpc_prod_snat                      = nsxt_policy_group.alpha_vpc_prod_snat.path
    vpc_kube_system_snat                     = nsxt_policy_group.vpc_kube_system_snat.path
    auto_attach                              = nsxt_policy_group.auto_attach.path
    metrics_aggregator                       = nsxt_policy_group.metrics_aggregator.path
    m01_sup01_kube_dns                       = nsxt_policy_group.m01_sup01_kube_dns.path
    harbor                                   = nsxt_policy_group.harbor.path
    contour_envoy                            = nsxt_policy_group.contour_envoy.path
    any_vks_cluster                          = nsxt_policy_group.any_vks_cluster.path
    m01_sup01_mgmt_proxy_lb                  = nsxt_policy_group.m01_sup01_mgmt_proxy_lb.path
    metrics_aggregator_lb                    = nsxt_policy_group.metrics_aggregator_lb.path
  }
}

output "service_paths" {
  description = "Map of NSX policy service name to path, consumed by the policy modules as module input variables."
  value = {
    icmp_all                  = data.nsxt_policy_service.icmp_all.path
    icmp_echo                 = data.nsxt_policy_service.icmp_echo.path
    dns_tcp                   = data.nsxt_policy_service.dns_tcp.path
    dns_udp                   = data.nsxt_policy_service.dns_udp.path
    dhcp_server               = data.nsxt_policy_service.dhcp_server.path
    dhcp_client               = data.nsxt_policy_service.dhcp_client.path
    https                     = data.nsxt_policy_service.https.path
    http                      = data.nsxt_policy_service.http.path
    ssh                       = data.nsxt_policy_service.ssh.path
    syslog_udp                = data.nsxt_policy_service.syslog_udp.path
    syslog_tcp                = data.nsxt_policy_service.syslog_tcp.path
    ntp                       = data.nsxt_policy_service.ntp.path
    tcp_1234_1235             = nsxt_policy_service.tcp_1234_1235.path
    tcp_6443                  = nsxt_policy_service.tcp_6443.path
    tcp_5000                  = nsxt_policy_service.tcp_5000.path
    tcp_10250                 = nsxt_policy_service.tcp_10250.path
    tcp_8053                  = nsxt_policy_service.tcp_8053.path
    tcp_9443                  = nsxt_policy_service.tcp_9443.path
    tcp_8081                  = nsxt_policy_service.tcp_8081.path
    tcp_10091_10092           = nsxt_policy_service.tcp_10091_10092.path
    tcp_10093                 = nsxt_policy_service.tcp_10093.path
    tcp_10349_10350_10351     = nsxt_policy_service.tcp_10349_10350_10351.path
    udp_6081                  = nsxt_policy_service.udp_6081.path
    tcp_5000_6443_10091_10093 = nsxt_policy_service.tcp_5000_6443_10091_10093.path
    tcp_6379                  = nsxt_policy_service.tcp_6379.path
    tcp_5443                  = nsxt_policy_service.tcp_5443.path
    tcp_5432                  = nsxt_policy_service.tcp_5432.path
    tcp_8443                  = nsxt_policy_service.tcp_8443.path
    tcp_30000_32767           = nsxt_policy_service.tcp_30000_32767.path
  }
}

output "context_profile_paths" {
  description = "Map of NSX context profile name to path, consumed by the policy modules as module input variables."
  value = {
    cxt_dns        = data.nsxt_policy_context_profile.cxt_dns.path
    internet_fqdns = nsxt_policy_context_profile.internet_fqdns.path
  }
}
