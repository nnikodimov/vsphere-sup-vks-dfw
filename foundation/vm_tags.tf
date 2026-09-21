data "nsxt_policy_vm" "sup01_ctrl_plane" {
  display_name = var.m01_sup01_ctrl_plane_vm

  context {
    project_id = var.m01_sup01_mgmt_project_id
  }
}

data "nsxt_policy_segment" "mgmt" {
  display_name = var.m01_sup01_mgmt_segment

  context {
    project_id = var.m01_sup01_mgmt_project_id
  }
}

resource "nsxt_policy_vm_tags" "sup01_ctrl_plane_mgmt_vif" {
  instance_id = data.nsxt_policy_vm.sup01_ctrl_plane.instance_id

  context {
    project_id = var.m01_sup01_mgmt_project_id
  }

  port {
    segment_path = data.nsxt_policy_segment.mgmt.path

    tag {
      scope = split("|", var.m01_sup01_mgmt_vif_tag)[0]
      tag   = split("|", var.m01_sup01_mgmt_vif_tag)[1]
    }
  }
}
