terraform {
  required_providers {
    bigip = {
      source  = "f5networks/bigip"
      version = "1.3.2"
    }
  }
}

provider "bigip" {
  //address = "10.145.67.133"
  address  = "10.145.73.178"
  username = "admin"
  password = "F5site02"
}

module bigip-consul-nia {
  source   = "../"
  services = var.services
}