<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | 3.2.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | 19.16.0 |
| <a name="module_network"></a> [network](#module\_network) | terraform-aws-modules/vpc/aws | 5.1.1 |
| <a name="module_postgres"></a> [postgres](#module\_postgres) | terraform-aws-modules/rds-aurora/aws | 8.3.1 |
| <a name="module_rds_security_group"></a> [rds\_security\_group](#module\_rds\_security\_group) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | 3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket_policy.cataloguing_mfe](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_iam_policy.ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ARN of the certificate | `string` |  | no |
| <a name="input_cdn_aliases"></a> [cdn\_aliases](#input\_cdn\_aliases) | The aliases name | `list(string)` |  | no |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Enter the version of your EKS cluster | `string` |  | no |
| <a name="input_database_private_subnets"></a> [database\_private\_subnets](#input\_database\_private\_subnets) | A list of database subnets CIDR inside the VPC | `list(string)` || no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | the type of the instance DB class | `any` | | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | password for db | `string` |  | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | username for db | `string` |  | no |
| <a name="input_eks_node_group_capacity_type"></a> [eks\_node\_group\_capacity\_type](#input\_eks\_node\_group\_capacity\_type) | Capacity of the node group instance to be | `string` |  | no |
| <a name="input_eks_node_group_desired_size"></a> [eks\_node\_group\_desired\_size](#input\_eks\_node\_group\_desired\_size) | Desired size of the eks node | `number` | | no |
| <a name="input_eks_node_group_instance_types"></a> [eks\_node\_group\_instance\_types](#input\_eks\_node\_group\_instance\_types) | Type of the node group instance to be | `list(string)` |  | no |
| <a name="input_eks_node_group_max_size"></a> [eks\_node\_group\_max\_size](#input\_eks\_node\_group\_max\_size) | maximum size of the eks node | `number` |  | no |
| <a name="input_eks_node_group_min_size"></a> [eks\_node\_group\_min\_size](#input\_eks\_node\_group\_min\_size) | minimum size of the eks node | `number` |  | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | The engine type for DB | `string` |  | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version for DB | `any` || no |
| <a name="input_environment"></a> [environment](#input\_environment) | the name of the environment | `string` |  | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | The id of the route53 zone | `string` | | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets CIDR inside the VPC | `list(string)` |  | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets CIDR inside the VPC | `list(string)` |  | no |
| <a name="input_rds_storage"></a> [rds\_storage](#input\_rds\_storage) | The storage of the DB instance | `number` | | no |
| <a name="input_record_name"></a> [record\_name](#input\_record\_name) | the name of the record | `string` |  | no |
| <a name="input_region"></a> [region](#input\_region) | the region in which to deploy resources | `string` |  | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | the name of the stack | `string` |  | no |
| <a name="input_vpc_cidr_range"></a> [vpc\_cidr\_range](#input\_vpc\_cidr\_range) | The CIDR range for your VPC |  |  | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
