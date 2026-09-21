data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}

resource "nsxt_policy_service" "tcp_6443" {
  display_name = "TCP-6443"
  description  = "Kubernetes API"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["6443"]
  }
}

resource "nsxt_policy_service" "tcp_30000_32767" {
  display_name = "TCP-30000-32767"
  description  = "Kubernetes NodePort"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["30000-32767"]
  }
}

resource "nsxt_policy_service" "tcp_61000_62000" {
  display_name = "TCP-61000-62000"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["61000-62000"]
  }
}
