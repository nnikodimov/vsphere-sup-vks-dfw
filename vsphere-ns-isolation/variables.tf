variable "nsx_project_id" {
  type        = string
  description = "ID of the NSX Project the vSphere Namespace isolation groups and policy are created in (e.g. \"default\")."
}

variable "ns_tag" {
  type        = string
  description = "SegmentPort tag (\"scope|value\") applied to the vSphere Namespace's ports, matched by the prod01-9lqzy group."
}

variable "dev01_h28ct_ns_tag" {
  type        = string
  description = "SegmentPort tag (\"scope|value\") applied to the dev01-h28ct vSphere Namespace's ports, matched by the dev01-h28ct group."
}

variable "vpc_lb_snat_cidr" {
  type        = string
  description = "CIDR allowed inbound to the namespace as the VPC load balancer's SNAT range, matched by the vpc-lb-snat group."
}

variable "alpha_project_id" {
  type        = string
  description = "ID of the alpha NSX Project, whose built-in default group (PROJECT-<id>-default) is used as the source for the namespace's DROP rule."
}
