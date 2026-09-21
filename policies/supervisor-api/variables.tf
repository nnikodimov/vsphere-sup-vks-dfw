variable "nsx_project_id" {
  type        = string
  description = "ID of the NSX Project the Supervisor API groups and policy are created in (e.g. \"system\")."
}

variable "transit_gateway_path" {
  type        = string
  description = "NSX policy path of the Transit Gateway the Supervisor API gateway firewall policy rules are scoped to, e.g. \"/orgs/default/projects/system/transit-gateways/default--<uuid>\"."
}

variable "api_clients" {
  type        = list(string)
  description = "IP addresses allowed to reach the Supervisor API over HTTPS, matched by the m01_sup01_api_clients group."
}

variable "api_fqdn_ip" {
  type        = string
  description = "IP address the m01-sup01.vcf01.ans.lab FQDN resolves to, matched by the FQDN-named destination group."
}
