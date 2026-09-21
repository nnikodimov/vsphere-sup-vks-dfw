variable "nsx_manager" {
  type        = string
  description = "Hostname or IP of the NSX Manager the provider connects to."
}

variable "nsx_username" {
  type        = string
  description = "NSX Manager username used by the provider. Set in secrets.auto.tfvars, not committed."
}

variable "nsx_password" {
  type        = string
  sensitive   = true
  description = "NSX Manager password used by the provider. Set in secrets.auto.tfvars, not committed."
}

variable "dns_server" {
  type        = string
  description = "IP address of the DNS server, matched by the dns_svc group."
}

variable "ntp_server" {
  type        = string
  description = "IP address of the NTP server, matched by the ntp_svc group."
}

variable "dhcp_server" {
  type        = string
  description = "IP address of the DHCP server, matched by the dhcp_svc group."
}

variable "vcfa" {
  type        = string
  description = "VM name prefix of the VCF Automation appliance(s), matched by the vcf_a group."
}

variable "vcfops_cp" {
  type        = string
  description = "VM name prefix of the VCF Operations control plane appliance(s), matched by the vcfops_cp group."
}

variable "m01_vc01" {
  type        = string
  description = "VM name prefix of the management domain vCenter Server, matched by the m01_vc group."
}

variable "m01_nsx01a" {
  type        = string
  description = "VM name prefix of the management domain NSX Manager node(s), matched by the m01_nsx group."
}

variable "m01_hosts" {
  type        = string
  description = "IP address or range of the management domain ESXi hosts, matched by the m01_hosts group."
}

variable "m01_avi01" {
  type        = string
  description = "VM name prefix of the management domain Avi (NSX Advanced Load Balancer) node(s), matched by the m01_avi group."
}

variable "m01_avi01_se_snat" {
  type        = string
  description = "IP address or CIDR of the Avi Service Engine SNAT range, matched by the m01_avi_se_snat group."
}

variable "m01_sup01_api" {
  type        = string
  description = "IP address of the Supervisor API load balancer VIP, matched by the m01_sup01_api group."
}

variable "m01_sup01_image_proxy" {
  type        = string
  description = "IP address of the Supervisor image/registry proxy VIP, matched by the m01_sup01_image_proxy group."
}

variable "ext_192_168_16_0_22" {
  type        = string
  description = "CIDR of the external workload network reachable from Supervisor/VKS, matched by the ext_192_168_16_0_22 group."
}

variable "ext_192_168_4_0_22" {
  type        = string
  description = "CIDR of the external management network reachable from Supervisor services, matched by the ext_192_168_4_0_22 group."
}

variable "alpha_vpc_prod_snat" {
  type        = string
  description = "IP address of the Alpha VPC production SNAT, matched by the alpha_vpc_prod_snat group."
}

variable "vpc_kube_system_snat" {
  type        = string
  description = "IP address of the VPC kube-system SNAT, matched by the vpc_kube_system_snat group."
}

variable "m01_sup01_kube_dns" {
  type        = string
  description = "IP address of the Supervisor cluster's CoreDNS service, matched by the m01_sup01_kube_dns group."
}

variable "m01_sup01_mgmt_proxy_lb" {
  type        = string
  description = "IP address of the Supervisor management proxy load balancer VIP, matched by the m01_sup01_mgmt_proxy_lb group."
}

variable "metrics_aggregator_lb" {
  type        = string
  description = "IP address or range of the metrics aggregator load balancer VIP, matched by the metrics_aggregator_lb group."
}

variable "m01_sup01_wld_tag" {
  type        = string
  description = "SegmentPort tag (\"scope|value\") applied to Supervisor workload namespace ports, matched by the m01_sup01_wld group."
}

variable "m01_sup01_mgmt_vif_tag" {
  type        = string
  description = "DVPort tag (\"scope|value\") applied to the Supervisor management VIF, matched by the m01_sup01_mgmt group."
}

variable "cci_ns_controller_manager" {
  type        = string
  description = "VM name prefix of the Cloud Consumption Interface namespace controller manager, matched by the cci_ns_controller_manager group."
}

variable "configuration_service_controller_manager" {
  type        = string
  description = "VM name prefix of the Configuration Service controller manager, matched by the configuration_service_controller_manager group."
}

variable "auto_attach" {
  type        = string
  description = "VM name prefix of the auto-attach service, matched by the auto_attach group."
}

variable "metrics_aggregator" {
  type        = string
  description = "VM name prefix of the metrics aggregator service, matched by the metrics_aggregator group."
}

variable "harbor" {
  type        = string
  description = "VM name prefix of the Harbor registry nodes, matched by the harbor group."
}

variable "contour_envoy" {
  type        = string
  description = "VM name prefix of the Contour Envoy ingress proxy nodes, matched by the contour_envoy group."
}

variable "vks_cluster_tag" {
  type        = string
  description = "SegmentPort tag (\"scope|\") applied to any VKS cluster node port, matched by the any_vks_cluster group."
}

variable "nsx_project_id" {
  type        = string
  description = "ID of the NSX Project the Supervisor API groups and gateway firewall policy are created in (e.g. \"system\")."
}

variable "m01_sup01_api_clients" {
  type        = list(string)
  description = "IP addresses allowed to reach the Supervisor API over HTTPS through the Transit Gateway firewall, matched by the m01_sup01_api_clients group."
}

variable "transit_gateway_path" {
  type        = string
  description = "NSX policy path of the Transit Gateway the Supervisor API gateway firewall policy rules are scoped to, e.g. \"/orgs/default/projects/system/transit-gateways/default--<uuid>\"."
}
