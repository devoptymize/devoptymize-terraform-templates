## S3 on AWS using Terraform Template

- This Terraform template is designed for creating and managing S3 on Amazon Web Services (AWS). It allows individuals and businesses to store and retrieve data, such as documents, images, videos, and backups, securely and durably in the cloud. S3 offers features like high scalability, data redundancy, versioning, and fine-grained access controls, making it suitable for a wide range of applications, from data archiving to hosting static websites and powering data analytics pipelines. 
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
| [module_s3_bucket](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest) | module |

## Resources

No resource

## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdn_name"></a> [Environment\_name](#input\_alias\_name) | The name of the environment in which resources needs to be provisioned. | `string` | `""` | Yes |
| <a name="input_distribution_type"></a> [bucket\_name](#input\_distribution\_type) |  A globally unique string that helps you organize and access your data within Amazon S3. Bucket names must be lowercase and can contain letters, numbers, hyphens, and periods. | `string` | `""` | yes |
| <a name="input_acm_certificate_arn"></a> [bucket\_key\_enabled](#input\_acm\_certificate\_arn) | Bucket key enabled (S3 Object Lambda) is a feature in Amazon S3 that allows you to execute custom code on data retrieved from S3 before it is returned to the requester.  | `string` | `""` | no |
| <a name="input_origin_shield"></a> [bucket\_policy](#input\_origin\_shield) | Bucket policies are typically written in JSON format and can be used to grant or restrict access to specific users, AWS accounts, or even the public | `string` | `""` | Yes |
