variable "nsx_project_name" {
  type        = string
  description = "Display name of the NSX Project the vSphere Namespace isolation group is created in (e.g. \"alpha\"), looked up to resolve its project ID."
}

variable "ns_tag" {
  type        = string
  description = "SegmentPort tag (\"scope|value\") applied to the vSphere Namespace's ports, matched by the prod01-9lqzy group."
}

variable "vpc_lb_snat_cidr" {
  type        = string
  description = "CIDR allowed inbound to the namespace as the VPC load balancer's SNAT range, matched by the vpc-lb-snat group."
}
