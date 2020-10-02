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

output "as3_json" {
  value = module.bigip-consul-nia.as3_json
}

// output "service_ids" {
//   value = module.bigip-consul-nia.service_ids
// }
