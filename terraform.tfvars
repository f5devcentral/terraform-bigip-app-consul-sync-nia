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
    node_id         = "00000000-0000-0000-0000-000000000000"
    node_address    = "192.168.10.10"
    node_datacenter = "dc1"
    node_tagged_addresses = {
      lan = "192.168.10.10"
      wan = "10.0.10.10"
    }
    node_meta = {
      somekey = "somevalue"
    }
  }
}