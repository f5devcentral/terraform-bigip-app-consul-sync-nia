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

module bigip-consul-terraform-sync {
  source   = "../"
  services = var.services
}

output "as3_json" {
  value = module.bigip-consul-terraform-sync.as3_json
}