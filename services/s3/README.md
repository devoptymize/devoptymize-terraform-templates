<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.10.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_key_enabled"></a> [bucket\_key\_enabled](#input\_bucket\_key\_enabled) | Specify whether to use an S3 Bucket Key for encryption | `bool` | `null` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket | `string` | `""` | no |
| <a name="input_bucket_policy"></a> [bucket\_policy](#input\_bucket\_policy) | The bucket policy rules in JSON format | `any` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | aws region | `string` | `""` | no |

<!-- END_TF_DOCS -->