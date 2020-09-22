terraform {
  required_providers {
    bigip = {
      source  = "f5networks/bigip"
      version = "1.3.2"
    }
  }
}

data "template_file" "as3_init" {
  //for_each = var.services
  template = file("${path.module}/as3.tmpl")
  vars = {
    tenant_name    = var.tenant_name,
    pool_name      = var.pool_name,
    server_address = jsonencode(setunion(local.addresses,[]))
    service_port   = 80
  }
}

resource "bigip_as3" "as3-example-consul" {
  //for_each = var.services
  as3_json = data.template_file.as3_init.rendered
}

locals {
  //as3_json = data.template_file.as3_init
  addresses = [
    for id, s in var.services :
    "${s.node_address}"
  ]
}

// output addresses {
//   value = setunion(local.addresses,[])
// }

