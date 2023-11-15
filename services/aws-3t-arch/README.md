# Refined 3-tier Architecture
- This Terraform scripts are used to create various AWS resources, including a Virtual Private Cloud (VPC), security groups, Auto Scaling Groups (ASG),Elastic Load Balancers (ALB), Amazon RDS (Relational Database Service), AWS CloudFront, and Route 53 records.
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
| <a name="module_alb_bcknd"></a> [alb\_bcknd](#module\_alb\_bcknd) | terraform-aws-modules/alb/aws | ~> 8.0 |
| <a name="module_alb_frntnd"></a> [alb\_frntnd](#module\_alb\_frntnd) | terraform-aws-modules/alb/aws | ~> 8.0 |
| <a name="module_asg_backend"></a> [asg\_backend](#module\_asg\_backend) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_asg_frontend"></a> [asg\_frontend](#module\_asg\_frontend) | terraform-aws-modules/autoscaling/aws | n/a |
| <a name="module_network"></a> [network](#module\_network) | terraform-aws-modules/vpc/aws | n/a |
| <a name="module_rds-postgres"></a> [rds-postgres](#module\_rds-postgres) | terraform-aws-modules/rds-aurora/aws | n/a |
| <a name="module_rds_db_subnet_group"></a> [rds\_db\_subnet\_group](#module\_rds\_db\_subnet\_group) | terraform-aws-modules/rds/aws//modules/db_subnet_group | 5.9.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.cf](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_route53_record.route53](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.rds_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_alb_bcknd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_alb_frntnd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_bcknd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.sg_frntnd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn_alb"></a> [acm\_certificate\_arn\_alb](#input\_acm\_certificate\_arn\_alb) | The acm certificate arn for the domain | `string` | `""` | no |
| <a name="input_acm_certificate_arn_cloudfront"></a> [acm\_certificate\_arn\_cloudfront](#input\_acm\_certificate\_arn\_cloudfront) | The acm certificate arn for the domain | `string` | `""` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The allocated storage for the rds | `number` | `null` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | The ID of the AMI to use for the instance | `string` | `""` | no |
| <a name="input_asg_desired_capacity"></a> [asg\_desired\_capacity](#input\_asg\_desired\_capacity) | Desired capacity of the autoscaling group | `number` | `null` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | Maximum size of auto-scaling group | `number` | `null` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | Minimum size of auto-scaling group | `number` | `null` | no |
| <a name="input_database_private_subnets"></a> [database\_private\_subnets](#input\_database\_private\_subnets) | A list of database subnets CIDR inside the VPC | `list(string)` | `[]` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The AWS RDS instance class for the database | `any` | `""` | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | The password of rds | `any` | `""` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | The username of rds | `any` | `""` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the domain | `string` | `""` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | choose the engine type | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | choose the engine version | `any` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which we need to provision infrastructure | `string` | `""` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The ID of the hosted zone in Route53 | `string` | `""` | no |
| <a name="input_ingressrules"></a> [ingressrules](#input\_ingressrules) | List of inbound rule for the security group | `any` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `""` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets CIDR inside the VPC | `list(string)` | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets CIDR inside the VPC | `list(string)` | `[]` | no |
| <a name="input_rds_cluster_identifier"></a> [rds\_cluster\_identifier](#input\_rds\_cluster\_identifier) | The name of your DB cluster | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where the resources will be deployed | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | This name will be the prefix to all the resources getting created | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of volume to attach to the instance | `number` | `null` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of the volume. eg gp2,gp3 | `string` | `""` | no |
| <a name="input_vpc_cidr_range"></a> [vpc\_cidr\_range](#input\_vpc\_cidr\_range) | The CIDR range for your VPC | `string` | `""` | no |
