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
