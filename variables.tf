variable "services" {
  description = "Consul services monitored by Consul NIA"
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

variable "tag_name" {
  description = "The name of the tag to create and use for dynamic address group filtering of Consul service IPs"
  type        = string
  default     = "consul-nia"
}

variable "consul_service_tags" {
  description = "Adminstrative tags to add to Consul service address objects. These are existing tags on PAN-OS."
  type        = list(string)
  default     = []
}

