## Hosted-zone on AWS using Terraform Template

- This Terraform template is designed for creating and managing Hosted-zone on Amazon Web Services (AWS). AWS Route 53 is a scalable and highly available Domain Name System (DNS) web service that allows you to route traffic to various AWS resources based on DNS records. 
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 


## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |

## Modules

| Name | Type |
|------|------|
| [module_private_hosted_zone](https://registry.terraform.io/modules/terraform-aws-modules/route53/aws/latest)) | module |
| [module_public_hosted_zone](https://registry.terraform.io/modules/terraform-aws-modules/route53/aws/latest) | module |

## Resources

No resource

## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdn_name"></a> [Environment\_name](#input\_alias\_name) | The name of the environment in which resources needs to be provisioned. | `string` | `""` | Yes |
| <a name="input_distribution_type"></a> [hostedzonename\_](#input\_distribution\_type) | The name for the hosted zone. For example, cloudifyops.com | `string` | `""` | yes |
| <a name="input_acm_certificate_arn"></a> [hosted\_zone\_type](#input\_acm\_certificate\_arn) | The type of the Hosted zone. The type can either be Public or Private | `string` | `""` | no |
| <a name="input_origin_shield"></a> [route53\_vpcname](#input\_origin\_shield) | The vpc_name to be associated to Hosted zone if it is a private one | `string` | `""` | Yes |
