data "nsxt_policy_service" "icmp_all" {
  display_name = "ICMP ALL"
}

data "nsxt_policy_service" "icmp_echo" {
  display_name = "ICMP Echo Request"
}

data "nsxt_policy_service" "dns_tcp" {
  display_name = "DNS-TCP"
}

data "nsxt_policy_service" "dns_udp" {
  display_name = "DNS-UDP"
}

data "nsxt_policy_service" "dhcp_server" {
  display_name = "DHCP-Server"
}

data "nsxt_policy_service" "https" {
  display_name = "HTTPS"
}

data "nsxt_policy_service" "http" {
  display_name = "HTTP"
}

data "nsxt_policy_service" "ssh" {
  display_name = "SSH"
}

data "nsxt_policy_service" "syslog_udp" {
  display_name = "Syslog (UDP)"
}

data "nsxt_policy_service" "syslog_tcp" {
  display_name = "Syslog (TCP)"
}

data "nsxt_policy_service" "ntp" {
  display_name = "NTP"
}

data "nsxt_policy_context_profile" "cxt_dns" {
  display_name = "DNS"
}

resource "nsxt_policy_service" "tcp_1234_1235" {
  description  = "NSX messaging"
  display_name = "TCP-1234_1235"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["1234","1235"]
  }
}

resource "nsxt_policy_service" "tcp_6443" {
  description  = "Kubernetes API"
  display_name = "TCP-6443"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["6443"]
  }
}

resource "nsxt_policy_service" "tcp_5000" {
  description  = "vSphere Supervizor"
  display_name = "TCP-5000"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["5000"]
  }
}

resource "nsxt_policy_service" "tcp_10250" {
  description  = "Kubelet API"
  display_name = "TCP-10250"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["10250"]
  }
}

resource "nsxt_policy_service" "tcp_8053" {
  description  = "Supervisor CoreDNS"
  display_name = "TCP-8053"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["8053"]
  }
}

resource "nsxt_policy_service" "tcp_9443" {
  description  = "vSphere IaaS Configuration Service"
  display_name = "TCP-9443"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["9443"]
  }
}

resource "nsxt_policy_service" "tcp_10091_10092" {
  description  = "Supervisor image/registry proxy"
  display_name = "TCP-10091_10092"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["10091-10092"]
  }
}

resource "nsxt_policy_service" "tcp_10093" {
  description  = "Supervisor metrics aggregator"
  display_name = "TCP-10093"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["10093"]
  }
}

resource "nsxt_policy_service" "tcp_10349_10350_10351" {
  description  = "VKS cluster control plane"
  display_name = "TCP-10349_10350_10351"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["10349", "10350", "10351"]
  }
}

resource "nsxt_policy_service" "udp_6081" {
  description  = "VKS cluster Geneve overlay"
  display_name = "UDP-6081"

  l4_port_set_entry {
    protocol          = "UDP"
    destination_ports = ["6081"]
  }
}

resource "nsxt_policy_service" "tcp_5000_6443_10091_10093" {
  description  = "Avi SE SNAT to Supervisor control plane"
  display_name = "TCP-5000_6443_10091-10093"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["5000", "6443", "10091-10093"]
  }
}

resource "nsxt_policy_service" "tcp_6379" {
  description  = "Harbor"
  display_name = "TCP-6379"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["6379"]
  }
}

resource "nsxt_policy_service" "tcp_5443" {
  description  = "Harbor"
  display_name = "TCP-5443"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["5443"]
  }
}

resource "nsxt_policy_service" "tcp_5432" {
  description  = "Harbor"
  display_name = "TCP-5432"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["5432"]
  }
}

resource "nsxt_policy_service" "tcp_8443" {
  description  = "Harbor"
  display_name = "TCP-8443"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["8443"]
  }
}

resource "nsxt_policy_service" "tcp_30000_32767" {
  description  = "Kubernetes NodePort"
  display_name = "TCP-30000–32767"

  l4_port_set_entry {
    protocol          = "TCP"
    destination_ports = ["30000-32767"]
  }
}

resource "nsxt_policy_context_profile_custom_attribute" "custom_fqdn1" {
  key       = "DOMAIN_NAME"
  attribute = "*.broadcom.com"
}

resource "nsxt_policy_context_profile_custom_attribute" "custom_fqdn2" {
  key       = "DOMAIN_NAME"
  attribute = "*.vmware.com"
}

resource "nsxt_policy_context_profile_custom_attribute" "custom_fqdn3" {
  key       = "DOMAIN_NAME"
  attribute = "*.broadcom.net"
}

resource "nsxt_policy_context_profile" "internet_fqdns" {
  display_name = "INTERNET_FQDNS"
  description  = "VCF upgrade and patch binaries"
  domain_name {
     value       = ["*.broadcom.com", "*.vmware.com", "*.broadcom.net"]
  }
  depends_on = [nsxt_policy_context_profile_custom_attribute.custom_fqdn1,nsxt_policy_context_profile_custom_attribute.custom_fqdn2,nsxt_policy_context_profile_custom_attribute.custom_fqdn3]
}