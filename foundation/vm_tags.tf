data "nsxt_policy_vm" "sup01_ctrl_plane" {
  display_name = var.m01_sup01_ctrl_plane_vm

  context {
    project_id = var.m01_sup01_mgmt_project_id
  }
}

data "nsxt_vpc" "mgmt" {
  display_name = var.m01_sup01_mgmt_vpc

  context {
    project_id = var.m01_sup01_mgmt_project_id
  }
}

data "nsxt_vpc_subnet" "mgmt" {
  display_name = var.m01_sup01_mgmt_subnet

  context {
    project_id = var.m01_sup01_mgmt_project_id
    vpc_id     = data.nsxt_vpc.mgmt.id
  }
}

data "nsxt_vpc_subnet_port" "sup01_ctrl_plane_mgmt" {
  subnet_path = data.nsxt_vpc_subnet.mgmt.path
  vm_id       = data.nsxt_policy_vm.sup01_ctrl_plane.external_id
}

resource "nsxt_policy_vm_tags" "sup01_ctrl_plane_mgmt_vif" {
  instance_id = data.nsxt_policy_vm.sup01_ctrl_plane.instance_id

  context {
    project_id = var.m01_sup01_mgmt_project_id
  }

  port {
    segment_path = data.nsxt_vpc_subnet_port.sup01_ctrl_plane_mgmt.path

    tag {
      scope = split("|", var.m01_sup01_mgmt_vif_tag)[0]
      tag   = split("|", var.m01_sup01_mgmt_vif_tag)[1]
    }
  }
}
