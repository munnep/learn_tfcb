# Week 5 TFC onboarding
#### https://developer.hashicorp.com/onboarding/tfcb-week-5

# Modules Overview
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/module

Description what modules are and how to use them

# Use Registry Modules in Configuration
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/module-use

Used the module to create a VPC with 2 EC2 instances. 

Made some small changes
- region "eu-north-1"
- instance type t3.micro
- image id to valid value for that region

```
Apply complete! Resources: 22 added, 0 changed, 0 destroyed.
```


# Build and Use a Local Module
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/module-create

Created a bucket with a webpage using a module

![](media/20230209114220.png)  

# Share Modules in the Private Registry
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/module-private-registry-share

Using modules in private registry Terraform Cloud  
![](media/20230209115040.png)    
![](media/20230209120258.png)    

# Add Public Providers and Modules to your Private Registry
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/private-registry-add

Adding public modules/providers to my local registry  
![](media/20230209120859.png)    

# Refactor Monolithic Terraform Configuration
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/organize-configuration

Some Terraform projects start as a monolith, a Terraform project managed by a single main configuration file in a single directory, with a single state file. Small projects may be convenient to maintain this way. However, as your infrastructure grows, restructuring your monolith into logical units will make your Terraform configurations less confusing and safer to manage.

splitting it with
- directories
- workspaces

The workspaces workflow feels more difficult in the long run to me then the directories workflow. With the directories workflow it is more clear to me in a single glance. 

# Module Creation - Recommended Pattern
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/pattern-module-creation

Make as many outputs as possible. This will always come in handy at a later point.

Other things explained made sense.

# Manage infrastructure collections with Workspaces
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/tfcb-w5-workspaces

Explanation about terraform and workspaces. Which can be practical with dev, test, acc, prod. 

# Import Terraform Configuration
### https://developer.hashicorp.com/onboarding/tfcb-week-5/state-import

Bringing existing infrastructure under Terraform's control involves five steps:

- Identify the existing infrastructure you will import.
- Import infrastructure into your Terraform state.
- Write Terraform configuration that matches that infrastructure.
- Review the Terraform plan to ensure the configuration matches the expected state and infrastructure.
- Apply the configuration to update your Terraform state.

With the following you can export the complete resource you just imported with all it's values. Playing around with it like this was extremely useful

Following is extremely important  
- Terraform doesn't detect default attributes that don't need to be set in your configuration.

```
terraform state show docker_container.web
# docker_container.web:
resource "docker_container" "web" {
    command           = [
        "nginx",
        "-g",
        "daemon off;",
    ]
    cpu_shares        = 0
    dns               = []
    dns_opts          = []
    dns_search        = []
    entrypoint        = [
        "/docker-entrypoint.sh",
    ]
    gateway           = "172.17.0.1"
    group_add         = []
    hostname          = "fea5b05705a0"
    id                = "fea5b05705a049a38f8f6da528d9dfa61a6e7d7c39d960349b507c226c94d8b7"
    image             = "sha256:3f8a00f137a0d2c8a2163a09901e28e2471999fde4efc2f9570b91f1c30acf94"
    init              = false
    ip_address        = "172.17.0.2"
    ip_prefix_length  = 16
    ipc_mode          = "private"
    links             = []
    log_driver        = "json-file"
    log_opts          = {}
    max_retry_count   = 0
    memory            = 0
    memory_swap       = 0
    name              = "hashicorp-learn"
    network_data      = [
        {
            gateway                   = "172.17.0.1"
            global_ipv6_address       = ""
            global_ipv6_prefix_length = 0
            ip_address                = "172.17.0.2"
            ip_prefix_length          = 16
            ipv6_gateway              = ""
            network_name              = "bridge"
        },
    ]
    network_mode      = "default"
    privileged        = false
    publish_all_ports = false
    read_only         = false
    restart           = "no"
    rm                = false
    security_opts     = []
    shm_size          = 64
    stdin_open        = false
    storage_opts      = {}
    sysctls           = {}
    tmpfs             = {}
    tty               = false

    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
```

# migrate state to Terraform Cloud
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/cloud-migrate

have it locally created. Then just add the following block under terraform

```
  cloud {
    organization = "patrickmunne"
    workspaces {
      name = "learn-terraform-cloud-migrate"
    }
  }
  ```

run terraform init and you will be asked if you want to transfer the state file

![](media/20230209135216.png)    

# Manage Resources in Terraform State
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/state-cli

using the terraform state mv command to actually move resources from one state file to another state file

```
$ terraform state mv -state-out=../terraform.tfstate aws_instance.example_new aws_instance.example_new
Move "aws_instance.example_new" to "aws_instance.example_new"
Successfully moved 1 object(s).

$ cd ..

$ terraform state list
data.aws_ami.ubuntu
aws_instance.example
aws_instance.example_new
aws_security_group.sg_8080
```

Good exercise because most of the time we used the `terraform state mv` command to make changes within the statefile

# Target resources
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/resource-targeting

Be careful when using -target because it could have some side effects. Mostly use it in troubleshooting scenario's

# Troubleshoot terraform
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/troubleshooting-workflow

There are 4 types of errors


- Language errors: The primary interface for Terraform is the HashiCorp Configuration Language (HCL), a declarative configuration language. The Terraform core application interprets the configuration language. When Terraform encounters a syntax error in your configuration, it prints out the line numbers and an explanation of the error.
- State errors: The Terraform state file stores information on provisioned resources. It maps resources to your configuration and tracks all associated metadata. If state is out of sync, Terraform may destroy or change your existing resources. After you rule out configuration errors, review your state. Ensure your configuration is in sync by refreshing, importing, or replacing resources.
- Core errors: The Terraform core application contains all the logic for operations. It interprets your configuration, manages your state file, constructs the resource dependency graph, and communicates with provider plugins. Errors produced at this level may be a bug. Later in this tutorial, you will learn best practices for opening a GitHub issue for the core development team.
- Provider errors: The provider plugins handle authentication, API calls, and mapping resources to services. Later in this tutorial, you will learn best practices for opening a GitHub issue for the provider development team.

Really good to remember if you have a resource with for_each then the output should be something like

```
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = [for instance in aws_instance.web_app : instance.id]
}
```

or use the following

```
output "instance_id_2" {
  description = "ID of the EC2 instance"
  value       = values(aws_instance.web_app)[*].id
}
```

# Manage Resource Drift
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/resource-drift

Gives a clear overview what happens when you change things outside of Terraform and that causes a drift when terraform compares your infrastructure to the state

# Manage Resource Lifecycle
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/resource-lifecycle

This was just a quick update of things I knew. 

# Version Remote State with the Terraform Cloud API
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/cloud-state-api

Nice to do it with the API and you have to remember to update the serial in the state file before uploading it again. 

# Use Refresh-Only Mode to Sync Terraform State
#### https://developer.hashicorp.com/onboarding/tfcb-week-5/refresh
