variable "services" {
  description = "Consul services monitored by consul-terraform-sync"
  type = map(
    object({
      id        = string
      name      = string
      address   = string
      port      = number
      status    = string
      meta      = map(string)
      tags      = list(string)
      namespace = string

      node                  = string
      node_id               = string
      node_address          = string
      node_datacenter       = string
      node_tagged_addresses = map(string)
      node_meta             = map(string)
    })
  )
}

variable "tenant_name" {
  description = "The name of the tenant"
  type        = string
  default     = "consul-terraform-sync"
}

variable "pool_name" {
  description = "The name of the web pool where consul-terraform-sync services will reside"
  type        = string
  default     = "web_pool"
}

variable "tag_name" {
  description = "The name of the tag to create and use for dynamic address group filtering of Consul service IPs"
  type        = string
  default     = "consul-terraform-sync"
}

variable "as3template_path" {
  description = "path of as3 template"
  //type        = string
  //default     = "${path.module}/default.tmpl"
}

variable "consul_service_tags" {
  description = "Adminstrative tags to add to Consul service address objects. These are existing tags on BIG-IP."
  type        = list(string)
  default     = []
}

