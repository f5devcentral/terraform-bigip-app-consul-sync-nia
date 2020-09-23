terraform {
  required_providers {
    bigip = {
      source  = "f5networks/bigip"
      version = "1.3.2"
    }
  }
}

data "template_file" "as3_init_service" {
  for_each = local.grouped
  template = file("${path.module}/as3_service.tmpl")
  vars = {
    app_name          = each.key
    vs_server_address = jsonencode(["10.10.10.10"])
    //vs_server_address = jsonencode({for i, r in each.value.*.meta:  })
    //vs_server_address = jsonencode(lookup({for i, r in each.value.*.node_meta:  i => r},"virtulserverip"))
    //vs_server_address = jsonencode([lookup(each.value, "virtulserverip")])
    pool_name = format("%s-pool", each.key)
    //server_address = jsonencode(setunion(["192.168.1.1"], []))
    server_address = jsonencode(setunion(each.value.*.node_address, []))
    service_port   = 80
  }
}

data "template_file" "as3_init" {
  for_each = local.grouped
  template = file("${path.module}/as3.tmpl")
  vars = {
    tenant_name       = var.tenant_name,
    app_name          = each.key
    vs_server_address = jsonencode(["10.10.10.10"])
    pool_name         = format("%s-pool", each.key)
    server_address    = jsonencode(setunion(each.value.*.node_address, []))
    service_port      = 80
  }
}

resource "bigip_as3" "as3-example-consul" {
  for_each = local.grouped
  as3_json = data.template_file.as3_init[each.key].rendered
}

locals {
  //as3_json = data.template_file.as3_init
  addresses = [
    for id, s in var.services :
    "${s.node_address}"
  ]

  # Create a map of service names to instance IDs
  service_ids = transpose({
    for id, s in var.services : id => [s.name]
    if lookup(s.meta, "VSIP", "") != "" && lookup(s.meta, "VSPORT", "") != ""
  })

  # Group service instances by name
  grouped = { for name, ids in local.service_ids :
    name => [
      for id in ids : var.services[id]
      if lookup(var.services[id].meta, "VSIP", "") != "" && lookup(var.services[id].meta, "VSPORT", "") != ""
    ]
  }
  app_list = [
    for id, s in local.grouped :
  s]

}
output "service_ids" {
  value = local.service_ids
}

output "service_instances" {
  //for_each = local.grouped
  value = local.grouped
}


// output addresses {
//   value = setunion(local.addresses,[])
// }

