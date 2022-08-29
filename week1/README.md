# TFCB Week 1 notes

Useful to use sometimes for example with curl to test something using the terraform output

```
curl $(terraform output -raw domain-name)
```

Hashicups application with a custom provider
https://github.com/hashicorp/learn-terraform-hashicups-provider

With terraform funtion slice you can get a part of a list

Get the values of the list by index 0 until but not including 3
```
 slice(var.private_subnet_cidr_blocks, 0, 3)
[
  "10.0.101.0/24",
  "10.0.102.0/24",
  "10.0.103.0/24",
]
```

Lists and maps are collection types. Terraform also supports two structural types. Structural types have a fixed number of values that can be of different types.

Tuple: A fixed-length sequence of values of specified types.
Object: A lookup table, matching a fixed set of keys to values of specified types.

With locals you can define locals and variables in the same block

```
locals {
  required_tags = {
    project     = var.project_name,
    environment = var.environment
  }
  tags = merge(var.resource_tags, local.required_tags)
}
```

Terraform lock file

| Provider | Version Constraint | terraform init (no lock file) | terraform init (lock file) |
| -------- | ------------------ | ----------------------------- | -------------------------- |
| aws      | >= 2.0.0           | Latest version (e.g. 4.11.0)  | Lock file version (2.50.0) |
| random   | 3.0.0              | 3.0.0                         | Lock file version (3.0.0)  |


Terraform versioning

| Required Version | Meaning                                            | Considerations                                                |
| ---------------- | -------------------------------------------------- | ------------------------------------------------------------- |
| 0.15.0           | Only Terraform v0.15.0 exactly                     | To upgrade Terraform, first edit the required_version setting |
| >= 0.15          | Any Terraform v0.15.0 or greater                   | Includes Terraform v1.0.0 and above                           |
| ~> 0.15.0        | Any Terraform v0.15.x, but not v1.0 or later       | Minor version updates are intended to be non-disruptive       |
| >= 0.15, < 2.0.0 | Terraform v0.15.0 or greater, but less than v2.0.0 | Avoids major version updates                                  |

