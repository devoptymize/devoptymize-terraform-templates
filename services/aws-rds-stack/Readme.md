## Amazon RDS on AWS using Terraform Template
- This Terraform scripts are used to create various AWS resources, including a Virtual Private Cloud (VPC), security groups, Auto Scaling Groups (ASG),Amazon EC2 (Elastic Cloud Compute), Amazon RDS (Relational Database Service), AWS Cloudwatch, AWS KMS (Key Management Service), and AWS SNS (Simple Notification Service).
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code.

## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-aws-modules/kms/aws | 1.5.0 |
| <a name="module_network"></a> [network](#module\_network) | terraform-aws-modules/vpc/aws | n/a |
| <a name="module_rds_db_subnet_group"></a> [rds\_db\_subnet\_group](#module\_rds\_db\_subnet\_group) | terraform-aws-modules/rds/aws//modules/db_subnet_group | 5.9.0 |        

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.db_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.high_cpu_alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_db_event_subscription.db_event_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_event_subscription) | resource |
| [aws_db_instance.master](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_instance.replica](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_sns_topic.db_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.db_notifications_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.cloudwatch_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The ID of the AMI to use for the instance | `string` | `""` | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | Desired capacity of the autoscaling group | `number` | `null` | no |      
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Maximum size of auto-scaling group | `number` | `null` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Minimum size of auto-scaling group | `number` | `null` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance class for the RDS instances | `string` | `""` | no |     
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | The master password for the RDS cluster | `string` | `""` | no |   
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | The master username for the RDS cluster | `string` | `""` | no |      
| <a name="input_email_address"></a> [email_address](#input\_email_address) | the email_address for sns notification | `list(string)` | <pre>[]</pre> | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | The type of the database engine | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version of the database engine | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name for the infrastructure | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `""` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | `""` | no |
| <a name="input_log_exports"></a> [log\_exports](#input\_log\_exports) | Enable CloudWatch logs exports | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets CIDR inside the VPC | `list(string)` | <pre>[]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets CIDR inside the VPC | `list(string)` | <pre>[]</pre> | no |
| <a name="input_rds_identifier"></a> [rds\_identifier](#input\_rds\_identifier) | The identifier of the RDS instance | `string` | `""` | no |
| <a name="input_rds_storage"></a> [rds\_storage](#input\_rds\_storage) | The allocated storage for the RDS instances | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be deployed | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | The stack name name for the stack | `string` | `""` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | The storage type of the rds instance | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of volume to attach to the instance | `number` | `null` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of the volume. eg gp2,gp3 | `string` | `""` | no |
| <a name="input_vpc_cidr_range"></a> [vpc\_cidr\_range](#input\_vpc\_cidr\_range) | The CIDR range for your VPC | `string` | `""` | no |


### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
