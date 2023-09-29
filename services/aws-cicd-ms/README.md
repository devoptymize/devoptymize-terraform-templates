<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |


## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codecommit_repository.codecommit_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_codepipeline.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_codestarnotifications_notification_rule.example_notification_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codestarnotifications_notification_rule) | resource |
| [aws_iam_policy.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.codebuild_cloudwatch_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_ecr_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_s3_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codepipeline_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.codebuild_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.pipeline_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket.artifact_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_sns_topic.sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.sns_topic_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `""` | no |
| <a name="input_branch_name"></a> [branch\_name](#input\_branch\_name) | Name of the branch in the CodeCommit repository that will be monitored for changes.Whenever changes are pushed to this branch, the pipeline will automatically start. | `string` | `""` | no |
| <a name="input_compute_type"></a> [compute\_type](#input\_compute\_type) | Type of the build environment that CodeBuild will use to build your application. | `string` | `""` | no |
| <a name="input_emails"></a> [emails](#input\_emails) | Email address to receive notifications via Amazon SNS (Simple Notification Service). You will receive status updates and notifications about pipeline events on this email address. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of env in which we need to provision the resources in AWS console. | `string` | `""` | no |
| <a name="input_image"></a> [image](#input\_image) | The Docker image for the build environment in CodeBuild. This image will be used to run the build process for your application. | `string` | `""` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of the AWS CodeCommit repository where your application source code is stored. | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | This name will be added as a prefix to all the resource names | `string` | `""` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the build environment that CodeBuild will use to build your application. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipeline_service_role_arn"></a> [pipeline\_service\_role\_arn](#output\_pipeline\_service\_role\_arn) | ARN of the CodePipeline Service Role |
<!-- END_TF_DOCS -->