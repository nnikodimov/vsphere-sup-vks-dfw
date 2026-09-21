data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}

resource "nsxt_policy_group" "m01_sup01_api_clients" {
  nsx_id       = "M01_SUP01_API_CLIENTS"
  display_name = "M01_SUP01_API_CLIENTS"
  group_type   = "IPAddress"

  context {
    project_id = var.nsx_project_id
  }

  criteria {
    ipaddress_expression {
      ip_addresses = var.api_clients
    }
  }
}

resource "nsxt_policy_group" "m01_sup01_api_fqdn" {
  nsx_id       = "M01_SUP01_API_FQDN"
  display_name = "m01-sup01.vcf01.ans.lab"
  group_type   = "IPAddress"

  context {
    project_id = var.nsx_project_id
  }

  criteria {
    ipaddress_expression {
      ip_addresses = [var.api_fqdn_ip]
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

  context {
    project_id = var.nsx_project_id
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
    display_name       = "Supervisor API Lockdown (IN)"
    destination_groups = [nsxt_policy_group.m01_sup01_api_fqdn.path]
    services           = [data.nsxt_policy_service.https.path]
    scope              = [var.transit_gateway_path]
    action             = "DROP"
    direction          = "IN"
    logged             = true
    log_label          = "m01_sup01_api"
  }
}
