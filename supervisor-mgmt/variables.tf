variable "groups" {
  type        = map(string)
  description = "Map of NSX policy group name to path, from the foundation module."
}

variable "services" {
  type        = map(string)
  description = "Map of NSX policy service name to path, from the foundation module."
}

variable "vcfsvc" {
  type        = string
  description = "VM name prefix of the VCF Services appliance(s), matched by the vcfsvc group."
}
