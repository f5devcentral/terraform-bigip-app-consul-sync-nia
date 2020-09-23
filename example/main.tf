terraform {
  required_providers {
    bigip = {
      source  = "f5networks/bigip"
      version = "1.3.2"
    }
  }
}

provider "bigip" {
  address  = var.bigip_host
  username = var.bigip_user
  password = var.bigip_passwd
}

module bigip-consul-nia {
  source   = "../"
  services = var.services
}

output "service_instances" {
  value = module.bigip-consul-nia.service_instances
}

output "service_ids" {
  value = module.bigip-consul-nia.service_ids
}
