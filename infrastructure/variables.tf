variable "groups" {
  type        = map(string)
  description = "Map of NSX policy group name to path, from the foundation module."
}

variable "services" {
  type        = map(string)
  description = "Map of NSX policy service name to path, from the foundation module."
}

variable "profiles" {
  type        = map(string)
  description = "Map of NSX context profile name to path, from the foundation module."
}
