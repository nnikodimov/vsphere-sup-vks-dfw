resource "nsxt_policy_group" "vcfsvc" {
  nsx_id       = "VCFSVC"
  display_name = "vcfsvc"

  criteria {
    condition {
      member_type = "VirtualMachine"
      key         = "Name"
      operator    = "STARTSWITH"
      value       = var.vcfsvc
    }
  }
}
