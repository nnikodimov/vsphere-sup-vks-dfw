variable "nsx_project_id" {
  type        = string
  description = "ID of the NSX Project the VKS cluster isolation groups and policy are created in (e.g. \"default\")."
}

variable "segment_tag" {
  type        = string
  description = "Segment tag (\"scope|value\") applied to the VKS cluster's subnet segment, matched by the vks01-cluster group."
}

variable "vpc_lb_snat_cidr" {
  type        = string
  description = "CIDR allowed inbound to the vks01-cluster as the VPC load balancer's SNAT range, matched by the vpc-lb-snat group."
}
