## Hosting WordPress on AWS using terraform template
- This Terraform scripts are used to create various AWS resources, including a Virtual Private Cloud (VPC), security groups, Auto Scaling Groups (ASG),Elastic Load Balancers (ALB), Amazon Elastic File System (EFS), Amazon ElastiCache, Amazon RDS (Relational Database Service), AWS CloudFront, and Route 53 records.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code

## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb"></a> [alb](#module\_alb) | terraform-aws-modules/alb/aws | ~> 8.0 |
| <a name="module_asg_app"></a> [asg\_app](#module\_asg\_app) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_asg_public"></a> [asg\_public](#module\_asg\_public) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | terraform-aws-modules/rds-aurora/aws | n/a |
| <a name="module_efs"></a> [efs](#module\_efs) | terraform-aws-modules/efs/aws | n/a |
| <a name="module_network"></a> [network](#module\_network) | terraform-aws-modules/vpc/aws | n/a |
| <a name="module_rds_db_subnet_group"></a> [rds\_db\_subnet\_group](#module\_rds\_db\_subnet\_group) | terraform-aws-modules/rds/aws//modules/db_subnet_group | 5.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.cf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_elasticache_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_subnet_group.elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_route53_record.route53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_app](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_elasticache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn_alb"></a> [acm\_certificate\_arn\_alb](#input\_acm\_certificate\_arn\_alb) | The acm certificate ARN | `string` | `""` | no |
| <a name="input_acm_certificate_arn_cloudfront"></a> [acm\_certificate\_arn\_cloudfront](#input\_acm\_certificate\_arn\_cloudfront) | The acm certificate ARN | `string` | `""` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage for the rds | `number` | `null` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | devoptymize bastion host ami | `string` | `""` | no |
| <a name="input_app_subnets"></a> [app\_subnets](#input\_app\_subnets) | A list of private subnets CIDR inside the VPC | `list(string)` | `[]` | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | minimum size of auto-scaling | `number` | `null` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | minimum size of auto-scaling | `number` | `null` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | minimum size of auto-scaling | `number` | `null` | no |
| <a name="input_data_subnets"></a> [data\_subnets](#input\_data\_subnets) | A list of database subnets CIDR inside the VPC | `list(string)` | `[]` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The AWS RDS instance class for the database | `any` | `""` | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | The password of rds | `any` | `""` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | The username of rds | `any` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | the name of the zone name | `string` | `""` | no |
| <a name="input_elasticache_node_type"></a> [elasticache\_node\_type](#input\_elasticache\_node\_type) | Node type of the elasticache | `any` | `""` | no |
| <a name="input_encrypted_boolean"></a> [encrypted\_boolean](#input\_encrypted\_boolean) | Create an encrypted Amazon EFS file system. | `bool` | `null` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | choose the engine type | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | choose the engine version | `any` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment name for the infrastructure | `string` | `""` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The id of the route53 zone | `string` | `""` | no |
| <a name="input_ingressrules"></a> [ingressrules](#input\_ingressrules) | List of ingress rules to create by name | `any` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `""` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The arn for the KMS key | `string` | `""` | no |
| <a name="input_log_exports"></a> [log\_exports](#input\_log\_exports) | Enable log exports to CloudWatch | `string` | `""` | no |
| <a name="input_number_of_subnets"></a> [number\_of\_subnets](#input\_number\_of\_subnets) | Select the number of subnets . | `number` | `null` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | Select the performance mode of the file system. | `string` | `""` | no |
| <a name="input_provisioned_throughput_mibps"></a> [provisioned\_throughput\_mibps](#input\_provisioned\_throughput\_mibps) | The throughput, measured in mebibytes per second (MiBps), that you want to provision for a file system that you're creating.(Required if ThroughputMode is set to provisioned). | `number` | `null` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets CIDR inside the VPC | `list(string)` | `[]` | no |
| <a name="input_rds_cluster_identifier"></a> [rds\_cluster\_identifier](#input\_rds\_cluster\_identifier) | The name of your DB cluster | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be deployed | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | The environment name for the infrastructure | `string` | `""` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | Specifies the throughput mode for the file system. The mode can be bursting, provisioned, or elastic. | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | List of volume sizes | `number` | `null` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | volume type | `string` | `""` | no |
| <a name="input_vpc_cidr_range"></a> [vpc\_cidr\_range](#input\_vpc\_cidr\_range) | The CIDR range for your VPC | `string` | `""` | no |


### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.



