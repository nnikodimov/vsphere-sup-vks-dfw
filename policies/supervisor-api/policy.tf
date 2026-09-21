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

resource "nsxt_policy_group" "m01_sup01_api_clients" {
  nsx_id       = "M01_SUP01_API_CLIENTS"
  display_name = "m01-sup01-api-clients"
  group_type   = "IPAddress"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  criteria {
    ipaddress_expression {
      ip_addresses = var.api_clients
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_api_fqdn" {
  nsx_id       = "M01_SUP01_API_FQDN"
  display_name = "m01-sup01-api-lb"
  group_type   = "IPAddress"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [var.api_fqdn_ip]
    }
  }
}

resource "nsxt_policy_group" "prj_ext_ip_block" {
  nsx_id       = "PRJ_EXT_IP_BLOCK"
  display_name = "prj-ext-ip-block"
  group_type   = "IPAddress"

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  criteria {
    ipaddress_expression {
      ip_addresses = var.allowlist_cidrs
    }
  }
}

resource "nsxt_policy_gateway_policy" "supervisor_api_policy" {
  display_name    = "Supervisor API Gateway Firewall Policy"
  category        = "LocalGatewayRules"
  locked          = false
  stateful        = true
  tcp_strict      = true
  sequence_number = 1

  dynamic "context" {
    for_each = var.nsx_project_id == "default" ? [] : [var.nsx_project_id]
    content {
      project_id = context.value
    }
  }

  rule {
    display_name       = "Supervisor API HTTPS (IN)"
    source_groups      = [nsxt_policy_group.m01_sup01_api_clients.path]
    destination_groups = [nsxt_policy_group.m01_sup01_api_fqdn.path]
    services           = [data.nsxt_policy_service.https.path]
    scope              = [var.transit_gateway_path]
    action             = "ALLOW"
    direction          = "IN"
    logged             = false
  }

  rule {
    display_name       = "Supervisor API HTTPS Lockdown (IN)"
    destination_groups = [nsxt_policy_group.m01_sup01_api_fqdn.path]
    services           = [data.nsxt_policy_service.https.path]
    scope              = [var.transit_gateway_path]
    action             = "DROP"
    direction          = "IN"
    logged             = true
    log_label          = "m01_sup01_api"
  }

  rule {
    display_name  = "Kubernetes API Allowlist (IN/OUT)"
    source_groups = [nsxt_policy_group.m01_sup01_api_clients.path, nsxt_policy_group.prj_ext_ip_block.path]
    services      = [nsxt_policy_service.tcp_6443.path]
    scope         = [var.transit_gateway_path]
    action        = "ALLOW"
    direction     = "IN_OUT"
    logged        = false
  }

  rule {
    display_name = "Kubernetes API Lockdown (IN/OUT)"
    services     = [nsxt_policy_service.tcp_6443.path]
    scope        = [var.transit_gateway_path]
    action       = "DROP"
    direction    = "IN_OUT"
    logged       = true
    log_label    = "tcp_6443"
  }
}
