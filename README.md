# BIG-IP Application Consul-Terraform-Sync Module

This terraform module leverages consul-terraform-sync to create and update application services on BIG-IP based on registered services within Consul.

terraform-bigip-app-consul-sync

## Terraform Version
This modules supports Terraform 0.13 and higher

## Notes
* Services definitions in consul must include meta-data for the BIG-IP VirtualServer IP and Port (see examples).
* Initial module hard codes the BIG-IP VirtualServer template to HTTP. Future versions may support additional application templates based  on github issues opened.
* Consul services must be listed within the *consul-terraform-sync* configuration.
* All consul services will be placed within the same AS3 Tenant on BIG-IP called **consul-terraform-sync**
* Application and Pool on BIG-IP will be named from the Consul Service


## Examples
The 3 service nodes in Consul below will create 2 AS3 applications on BIG-IP with pool members as the node_addresses from consul.



### Consul Service Input

  ```
    {
        "Node": "node1",
        "Address": "10.27.39.27",
        "Service": {
            "ID": "node1",
            "Service": "f5s1",
            "Address": "10.27.39.27",
            "Meta": {
                "VSIP": "10.39.27.5",
                "VSPORT": "8080"
            },
            "Port": 8000
        }
    },
    {
        "Node": "node2",
        "Address": "10.27.39.28",
        "Service": {
            "ID": "node2",
            "Service": "f5s1",
            "Address": "10.27.39.28",
            "Meta": {
                "VSIP": "10.39.27.5",
                "VSPORT": "8080"
            },
            "Port": 8000
        }
    },
    {
        "Node": "node3",
        "Address": "10.27.39.29",
        "Service": {
            "ID": "node3",
            "Service": "f5s2",
            "Address": "10.27.39.29",
            "Meta": {
                "VSIP": "10.39.27.6",
                "VSPORT": "80"
            },
            "Port": 8000
        }
    }
  ```

### BIG-IP Applications (AS3)
App: f5s1
App: f5s2
| App | VirtualServer | Members | 
|------|-------------|------|
| f5s1 | 10.39.27.5:8080 | 10.27.39.27 10.27.39.28  |
| f5s2 | 10.39.27.6:80 | 10.27.39.29 |


### Config for consul-terraform-sync

```
driver "terraform" {
  log = true
  required_providers {
    bigip = {
      source = "F5Networks/bigip"
    }
  }
}
consul {
  address = "10.1.2.3.4:8500"
}

provider "bigip" {
  address  = "10.1.2.5:8443"
  username = "admin"
  password = "pass"
}

task {
  name = "AS3"
  description = "AS3 HTTP APPS"
  source = "f5devcentral/bigip/app-consul-sync"
  providers = ["bigip"]
  services = []
  variable_files = ["/Users/test/test.tfvars"]
}
```

