# TFCB Week 2 notes

## Sentinel example

coming from the repository: https://github.com/hashicorp/learn-terraform-enforce-policies


file: `sentinel.hcl`

```
policy "allowed-terraform-version" {
    enforcement_level = "soft-mandatory"
}
```

file `allowed-terraform-version.sentinel`
```
import "tfplan"
import "version"

# This regular expression checks whether the Terraform version used for the plan is 0.14+, 0.15+, or 1.0+

main = rule {
  version.new(tfplan.terraform_version).greater_than("1.1.0")
}
```

# docker provider

You can manage docker on your desktop with the following prodider

```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.21.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
```