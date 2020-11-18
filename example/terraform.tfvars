services = {
  "web_api" : {
    address = "172.17.0.3"
    id      = "web_api"
    name    = "foobar"
    port    = 5000
    meta = {
      VSIP    = "10.10.10.10"
      VSPORT  = 80
      AS3TMPL = "http"
    }
    status          = "passing"
    tags            = ["tacos"]
    namespace       = "default"
    node            = "foobar"
    node_id         = "node_a"
    node_address    = "192.168.10.10"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.10"
      wan = "10.0.10.10"
    }
    node_meta = {}
  },
  "web_api2" : {
    address = "172.17.0.4"
    id      = "web_api2"
    name    = "foobar"
    port    = 5000
    meta = {
      VSIP    = "10.10.10.10"
      VSPORT  = 80
      AS3TMPL = "http"
    }
    status          = "passing"
    tags            = ["tacos"]
    namespace       = "default"
    node            = "foobar"
    node_id         = "node_a"
    node_address    = "192.168.10.11"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.10"
      wan = "10.0.10.10"
    }
    node_meta = {}
  },
  "web_1" : {
    address = "172.18.0.3"
    id      = "web_1"
    name    = "web"
    port    = 5000
    meta = {
      VSIP    = "10.10.10.10"
      VSPORT  = 8080
      AS3TMPL = "tcp"
    }
    tags            = ["tacos"]
    namespace       = null
    status          = "passing"
    node_id         = "node_a"
    node            = "foobar"
    node_address    = "192.168.10.10"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.10"
      wan = "10.0.10.10"
    }
    node_meta = {
      somekey = "somevalue"
    },
  },
  "web_2" : {
    address = "172.17.0.3"
    id      = "web_2"
    name    = "web"
    port    = 5000
    meta = {
      VSIP    = "10.10.10.10"
      VSPORT  = 8080
      AS3TMPL = "tcp"
    }
    tags            = ["burrito"]
    namespace       = null
    status          = "passing"
    node_id         = "node_b"
    node            = "foobarbaz"
    node_address    = "192.168.10.12"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.11"
      wan = "10.0.10.10"
    }
    node_meta = {}
  }
}
bigip_host   = "10.145.73.178"
bigip_user   = "admin"
bigip_passwd = "F5site02"
