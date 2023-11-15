## Key Pair on AWS using Terraform Template

- This Terraform template is designed for creating and managing Key pair on Amazon Web Services (AWS).An AWS Key Pair is a secure and essential component for accessing and managing Amazon EC2 instances. It consists of a public key for encrypting data and a private key for decrypting it, providing secure SSH access to EC2 instances and enhancing security.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 


## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed


## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_pair"></a> [key\_pair](#module\_key\_pair) | terraform-aws-modules/key-pair/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.ssh_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |    

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_key_pair_name"></a> [key\_pair\_name](#input\_key\_pair\_name) | The name for the key pair. Conflicts with `key_name_prefix` | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `""` | no |


### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
