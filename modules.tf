module "foundation" {
  source = "./foundation"

  dns_server                               = var.dns_server
  ntp_server                               = var.ntp_server
  dhcp_server                              = var.dhcp_server
  vcfa                                     = var.vcfa
  vcfops_cp                                = var.vcfops_cp
  m01_vc01                                 = var.m01_vc01
  m01_nsx01a                               = var.m01_nsx01a
  m01_hosts                                = var.m01_hosts
  m01_avi01                                = var.m01_avi01
  m01_avi01_se_snat                        = var.m01_avi01_se_snat
  m01_sup01_api                            = var.m01_sup01_api
  m01_sup01_image_proxy                    = var.m01_sup01_image_proxy
  ext_192_168_16_0_22                      = var.ext_192_168_16_0_22
  ext_192_168_4_0_22                       = var.ext_192_168_4_0_22
  alpha_vpc_prod_snat                      = var.alpha_vpc_prod_snat
  vpc_kube_system_snat                     = var.vpc_kube_system_snat
  m01_sup01_kube_dns                       = var.m01_sup01_kube_dns
  m01_sup01_mgmt_proxy_lb                  = var.m01_sup01_mgmt_proxy_lb
  metrics_aggregator_lb                    = var.metrics_aggregator_lb
  m01_sup01_wld_tag                        = var.m01_sup01_wld_tag
  m01_sup01_mgmt_vif_tag                   = var.m01_sup01_mgmt_vif_tag
  cci_ns_controller_manager                = var.cci_ns_controller_manager
  configuration_service_controller_manager = var.configuration_service_controller_manager
  auto_attach                              = var.auto_attach
  metrics_aggregator                       = var.metrics_aggregator
  harbor                                   = var.harbor
  contour_envoy                            = var.contour_envoy
  vks_cluster_tag                          = var.vks_cluster_tag
}

module "infrastructure" {
  source = "./policies/infrastructure"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
  profiles = module.foundation.context_profile_paths
}

module "supervisor-mgmt" {
  source = "./policies/supervisor-mgmt"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "supervisor-wld" {
  source = "./policies/supervisor-wld"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "supervisor-svc" {
  source = "./policies/supervisor-svc"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "harbor" {
  source = "./policies/harbor"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "vks" {
  source = "./policies/vks"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}
