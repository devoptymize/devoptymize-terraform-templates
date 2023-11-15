## AWS loadbalancer using terraform template
- This Terraform scripts are used to create loadbalancer in AWS cloud.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code


## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb"></a> [lb](#module\_lb) | terraform-aws-modules/alb/aws | ~> 8.0 |

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Choose the action for the load balancer | `string` | `""` | no |
| <a name="input_alpn_policy"></a> [alpn\_policy](#input\_alpn\_policy) | select the ALPN policy | `any` | `null` | no |
| <a name="input_certificate_list"></a> [certificate\_list](#input\_certificate\_list) | The ARN of the SSL certificate for HTTPS traffic | `string` | `null` | no |
| <a name="input_certificate_name"></a> [certificate\_name](#input\_certificate\_name) | Name of the SSL certificate | `any` | `null` | no |
| <a name="input_credential"></a> [credential](#input\_credential) | choose the credentials | `any` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The AWS environment (e.g., dev, prod) | `string` | `""` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | The IP address type of the load balancer (ipv4 or dualstack) | `any` | `""` | no |
| <a name="input_loadbalancer_name"></a> [loadbalancer\_name](#input\_loadbalancer\_name) | The name of your load balancer | `string` | `""` | no |
| <a name="input_loadbalancer_type"></a> [loadbalancer\_type](#input\_loadbalancer\_type) | The type of the load balancer to create (nlb or alb) | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | mention the port number | `any` | `""` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol of the load balancer listener | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be provisioned | `string` | `""` | no |
| <a name="input_scheme"></a> [scheme](#input\_scheme) | The load balancer scheme (internet-facing or internal) | `any` | `""` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | List of security group IDs associated with the load balancer | `list(string)` | `[]` | no |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | The security policy for SSL connections | `any` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The list of subnet IDs where the load balancer will be deployed | `list(string)` | `[]` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | The name of the subnet | `any` | `""` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | The ARN of the target group for the listeners | `any` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id for the Vpc | `any` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The name of the vpc | `any` | `""` | no |

## Outputs

### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
