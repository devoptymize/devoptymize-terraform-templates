<!-- BEGIN_TF_DOCS -->
#  AWS DevOps pipeline architecture - CI/CD of Static-website (S3 CDN stack)

## Description
![Image](./aws-cicd-sw.png)
AWS DevOps pipeline architecture for CI/CD of a static website is versatile and can be utilized by a broad range of stakeholders involved in the software development lifecycle. It promotes collaboration, automation, and efficiency in delivering static website updates to production environments.
The goal is to automate the build, testing, and deployment processes to achieve faster and more reliable software releases while maintaining the highest level of security and scalability. The blueprint is able to create the pipeline with Continuous Integration and Continuous Deployment (CI/CD) of a static website hosted on an S3 bucket with a CDN (Content Delivery Network) stack into the single pipeline.
- Who can use AWS DevOps pipeline architecture - CI/CD of Static-website (S3 CDN stack):
    - Developers can use the CI/CD pipeline to automate the building and deployment of their static website code. They benefit from faster feedback loops, ensuring that changes are deployed consistently and quickly.
    - DevOps engineers are responsible for designing and implementing CI/CD pipelines. They can leverage this blueprint to create a scalable, automated deployment process for static websites.
    - QA teams may use the CI/CD pipeline to deploy different versions of the static website for testing purposes. Automated testing steps can be added to the pipeline to ensure the quality of the deployed code.
    - Infrastructure engineers can benefit from the Infrastructure as Code (IaC) components of the blueprint. They can manage and version control the AWS infrastructure using CloudFormation or Terraform.
    - Release managers can use the pipeline to orchestrate the release process, ensuring that the correct version of the website is deployed to production and other environments.
    - Project managers can benefit from the streamlined and automated deployment process. They can track the progress of deployments and ensure that timelines are met.
    - Technical leads can guide and lead the implementation of the CI/CD pipeline, making architectural decisions and ensuring that the pipeline meets performance and scalability requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.codebuild_project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codecommit_repository.codecommit_repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository) | resource |
| [aws_codepipeline.codepipeline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_iam_policy.cloudfront_invalidation_lambda_function_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codebuild_lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.codepipeline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_attachment.cloudfront_invalidation_lambda_function_awscodepipeline_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.cloudfront_invalidation_lambda_function_cloudfront_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.cloudfront_invalidation_lambda_function_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_cloudwatch_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_lambda_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codebuild_s3_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_policy_attachment.codepipeline_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.cloudfront_invalidation_lambda_function_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.codebuild_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.pipeline_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.cloudfront_invalidation_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_sns_topic.sns_topic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [archive_file.lambda](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `""` | no |
| <a name="input_branch_name"></a> [branch\_name](#input\_branch\_name) | Name of the branch in the CodeCommit repository that will be monitored for changes.Whenever changes are pushed to this branch, the pipeline will automatically start. | `string` | `""` | no |
| <a name="input_compute_type"></a> [compute\_type](#input\_compute\_type) | Type of the build environment that CodeBuild will use to build your application. | `string` | `""` | no |
| <a name="input_emails"></a> [emails](#input\_emails) | Email address to receive notifications via Amazon SNS (Simple Notification Service). You will receive status updates and notifications about pipeline events on this email address. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of resource that we need to create in AWS console. | `string` | `""` | no |
| <a name="input_image"></a> [image](#input\_image) | The Docker image for the build environment in CodeBuild. This image will be used to run the build process for your application. | `string` | `""` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | Name of the AWS CodeCommit repository where your application source code is stored. | `string` | `""` | no |
| <a name="input_s3bucketname"></a> [s3bucketname](#input\_s3bucketname) | Name of the Existing Amazon S3 bucket where the artifacts generated by the build process will be stored . | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | The name of resource that we need to create in AWS console. | `string` | `""` | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the build environment that CodeBuild will use to build your application. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipeline_service_role_arn"></a> [pipeline\_service\_role\_arn](#output\_pipeline\_service\_role\_arn) | ARN of the CodePipeline Service Role |
<!-- END_TF_DOCS -->
