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
  m01_sup01_ctrl_plane_vm                  = var.m01_sup01_ctrl_plane_vm
  m01_sup01_mgmt_vpc                       = var.m01_sup01_mgmt_vpc
  m01_sup01_mgmt_subnet                    = var.m01_sup01_mgmt_subnet
  m01_sup01_mgmt_project_id                = var.m01_sup01_mgmt_project_id
  cci_ns_controller_manager                = var.cci_ns_controller_manager
  configuration_service_controller_manager = var.configuration_service_controller_manager
  auto_attach                              = var.auto_attach
  metrics_aggregator                       = var.metrics_aggregator
  harbor                                   = var.harbor
  contour_envoy                            = var.contour_envoy
  vks_cluster_tag                          = var.vks_cluster_tag
}

module "infrastructure" {
  source = "./infrastructure"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
  profiles = module.foundation.context_profile_paths
}

module "supervisor-mgmt" {
  source = "./supervisor-mgmt"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "supervisor-wld" {
  source = "./supervisor-wld"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "supervisor-svc" {
  source = "./supervisor-svc"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "harbor" {
  source = "./harbor"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

module "vks-control-plane" {
  source = "./vks-control-plane"

  groups   = module.foundation.group_paths
  services = module.foundation.service_paths
}

moved {
  from = module.vks
  to   = module.vks-control-plane
}

module "supervisor-api" {
  source = "./supervisor-api"

  nsx_project_id       = var.nsx_project_id
  transit_gateway_path = var.transit_gateway_path
  api_clients          = var.m01_sup01_api_clients
  api_fqdn_ip          = var.m01_sup01_api
  allowlist_cidrs      = var.prj_ext_ip_block_cidrs
}

module "vsphere-ns-isolation" {
  source = "./vsphere-ns-isolation"

  nsx_project_id   = var.nsx_project_id
  ns_tag           = var.prod01_9lqzy_ns_tag
  vpc_lb_snat_cidr = var.vpc_lb_snat_cidr
}

module "vks-cluster-isolation" {
  source = "./vks-cluster-isolation"

  nsx_project_id   = var.nsx_project_id
  segment_tag      = var.vks01_segment_tag
  vpc_lb_snat_cidr = var.vpc_lb_snat_cidr
}
