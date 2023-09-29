<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | terraform-aws-modules/ecr/aws | n/a |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | Provide a concise name. A developer should be able to identify the repository contents by the name. | `string` | `""` | no |
| <a name="input_image_count"></a> [image\_count](#input\_image\_count) | Specify the number of images to be stored in the ECR repository. | `number` | `null` | no |
| <a name="input_read_access_arns"></a> [read\_access\_arns](#input\_read\_access\_arns) | Select the appropriate users arn who can have read access to ecr repo | `list(string)` | `[]` | no |
| <a name="input_read_write_access_arns"></a> [read\_write\_access\_arns](#input\_read\_write\_access\_arns) | Select the appropriate users arn who can have read and write access to ecr repo | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the ECR will be created | `string` | `""` | no |
| <a name="input_repository_image_tag_mutability"></a> [repository\_image\_tag\_mutability](#input\_repository\_image\_tag\_mutability) | Enable tag immutability to prevent image tags from being overwritten by subsequent image pushes using the same tag. Disable tag immutability to allow image tags to be overwritten. | `string` | `""` | no |
| <a name="input_repository_type"></a> [repository\_type](#input\_repository\_type) | Select the type of the ECR repo. Can be either a public or private one | `string` | `""` | no |
| <a name="input_scan_repo"></a> [scan\_repo](#input\_scan\_repo) | Enable scan on push to have each image automatically scanned after being pushed to a repository. If disabled, each image scan must be manually started to get scan results. | `bool` | `null` | no |

<!-- END_TF_DOCS -->