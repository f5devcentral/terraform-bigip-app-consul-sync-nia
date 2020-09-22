services = {
  "web_api" : {
    address = "172.17.0.3"
    id      = "web_api"
    name    = "foobar"
    port    = 5000
    status  = "passing"
    meta = {
      foobar_meta_value = "baz"
    }
    tags            = ["tacos"]
    namespace       = "default"
    node            = "foobar"
    node_id         = "node_c"
    node_address    = "192.168.10.10"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.10"
      wan = "10.0.10.10"
    }
    node_meta = {
      somekey = "somevalue"
    }
  },
  "web_1" : {
    address = "172.17.0.3"
    id      = "web_1"
    name    = "web"
    port    = 5000
    meta = {
      foobar_meta_value = "baz"
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
      foobar_meta_value = "baz"
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