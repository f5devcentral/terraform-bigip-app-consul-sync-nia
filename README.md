# BIG-IP Application Consul-Terraform-Sync Module

This terraform module leverages consul-terraform-sync to create and update application services on BIG-IP based on registered services within Consul. Please open github issues with feature requests or bugs for further advancement.

Please find more information about setting up your environment with **Consul Network Infrastructure Automation (NIA)** within its [Documentation Page](https://www.consul.io/docs/nia/tasks).

terraform-bigip-app-consul-sync-nia

<p align="left">
<img width="100%"   src="https://raw.githubusercontent.com/f5devcentral/terraform-bigip-app-consul-sync-nia/master/images/cts.drawio.png"> </a>
</p>
                                                                                                                                     
                                                                                                                                     
## Requirements

* BIG-IP AS3 >= 3.20

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| consul-terraform-sync | >= 0.1.0 |
| consul | >= 1.7 |

## Providers

| Name | Version |
|------|---------|
| bigip | ~> 1.3.2 |

## Setup / Notes
* Service definitions in consul must include meta-data for the BIG-IP VirtualServer IP (VSIP), Port (VSPORT), and AS3 Template name (AS3TMPL)...(see examples).
* AS3 templates must be placed within a directory and then referenced within tfvars using `as3template_path`. The module ships with an HTTP and TCP template as en example if this is not specified to a directory containing your customer templates.
* Consul services that you wish to auto-update must be listed within the *consul-terraform-sync* configuration of the *Task*.
* All consul services will be placed within the same AS3 Tenant on BIG-IP named **consul-terraform-sync** by default. You can override this by adding a variable called **tenant_name** to your tfvars file.
* There will be a placeholder irule placed within the BIG-IP tenant to prevent it from being accidently removed when no services are defined.
* The Application and Pool on BIG-IP will be named from the Consul Service


## Examples
The 3  example service nodes in Consul below will create 2 AS3 applications on BIG-IP with pool members as the node_addresses from consul.



### Consul Services (Input)
The API payloads for consul services registration below are used as examples. The same input would normally be provided through the HCL configuration when a service node registers itself.

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
                "VSPORT": "8080",
                "AS3TMPL": "http"
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
                "VSPORT": "8080",
                "AS3TMPL": "http"
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
                "VSPORT": "22",
                "AS3TMPL": "tcp"
            },
            "Port": 22
        }
    }
  ```

  The data is then transformed via **Consul-Terraform-Sync** and provided to the Terraform module as an input variable.

### BIG-IP Applications (AS3 Output)

The Terraform module transforms the Consul services into BIG-IP applications using the templates defined (TCP/HTTP by default).


| App | VirtualServer | Members | 
|------|-------------|------|
| f5s1 (http app) | 10.39.27.5:8080 | 10.27.39.27 10.27.39.28  |
| f5s2 (tcp app) | 10.39.27.6:22 | 10.27.39.29 |


### Config for consul-terraform-sync

Note that the tfvars variable file for this module has 2 primary variable inputs.
* **as3template_path** to specify the path where your AS3 templates are stored. This one should always be used in a production environment as it will be unlikely that the example http/tcp templates will meet your application eactly.
* **tenant_name** if you would like to use a specific partition on the BIG-IP with AS3


``` terraform
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

provider_terraform "bigip" {
  address  = "10.1.2.5:8443"
  username = "admin"
  password = "pass"
}

task {
  name = "AS3"
  description = "Create AS3 Applications"
  source = "f5devcentral/app-consul-sync-nia/bigip"
  providers = ["bigip"]
  services = ["f5s1","f5s2"]
  variable_files = ["/Optional/test.tfvars"]
}
```

