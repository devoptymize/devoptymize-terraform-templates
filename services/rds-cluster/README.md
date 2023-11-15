# RDS CLUSTER

## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster"></a> [cluster](#module\_cluster) | terraform-aws-modules/rds-aurora/aws | 5.16.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_parameter_group"></a> [cluster\_parameter\_group](#input\_cluster\_parameter\_group) | Name of the cluster parameter group to associate with the DB cluster | `any` | `""` | no |
| <a name="input_cluster_parameter_group_new"></a> [cluster\_parameter\_group\_new](#input\_cluster\_parameter\_group\_new) | Name of a new cluster parameter group to associate with the DB cluster | `any` | `""` | no |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance class of the DB instances within the cluster | `any` | `""` | no |
| <a name="input_db_instance_one"></a> [db\_instance\_one](#input\_db\_instance\_one) | Identifier for the first DB instance (if not using default settings) | `any` | `""` | no |
| <a name="input_db_instance_one_custom"></a> [db\_instance\_one\_custom](#input\_db\_instance\_one\_custom) | Custom settings for the first DB instance (if not using default settings) | `any` | `null` | no |
| <a name="input_db_instance_three"></a> [db\_instance\_three](#input\_db\_instance\_three) | Identifier for the third DB instance (if not using default settings) | `any` | `""` | no |
| <a name="input_db_instance_three_custom"></a> [db\_instance\_three\_custom](#input\_db\_instance\_three\_custom) | Custom settings for the third DB instance (if not using default settings) | `any` | `null` | no |
| <a name="input_db_instance_two"></a> [db\_instance\_two](#input\_db\_instance\_two) | Identifier for the second DB instance (if not using default settings) | `any` | `""` | no |
| <a name="input_db_instance_two_custom"></a> [db\_instance\_two\_custom](#input\_db\_instance\_two\_custom) | Custom settings for the second DB instance (if not using default settings) | `any` | `null` | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Master Password for the DB cluster | `any` | `""` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | Master username for the DB cluster | `any` | `""` | no |
| <a name="input_dbparameter_family"></a> [dbparameter\_family](#input\_dbparameter\_family) | The DB parameter family name for the DB cluster | `any` | `""` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | Encryption configuration for the DB cluster | `any` | `""` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | Choose the  database engine type for the RDS cluster | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | Choose the database engine version for the RDS cluster | `string` | `""` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster | `number` | `1000` | no |
| <a name="input_log_exports"></a> [log\_exports](#input\_log\_exports) | Log types to export to CloudWatch Logs | `string` | `""` | no |
| <a name="input_parameter_group"></a> [parameter\_group](#input\_parameter\_group) | Name of the parameter group | `any` | `""` | no |
| <a name="input_parameter_group_new"></a> [parameter\_group\_new](#input\_parameter\_group\_new) | Name of a new parameter group to associate with the DB cluster | `any` | `""` | no |
| <a name="input_public_access"></a> [public\_access](#input\_public\_access) | Determines if the DB instances should have public access | `string` | `""` | no |
| <a name="input_rds_cluster_identifier"></a> [rds\_cluster\_identifier](#input\_rds\_cluster\_identifier) | The name of your DB cluster | `string` | `""` | no |
| <a name="input_rds_storage"></a> [rds\_storage](#input\_rds\_storage) | The amount of allocated storage for the DB cluster | `number` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | choose the region where the RDS to create | `string` | `""` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The IDs of the security groups for the DB cluster | `list(string)` | `[]` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group for the DB cluster | `string` | `""` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Specifies the storage type to be associated with the DB cluster. (This setting is required to create a Multi-AZ DB cluster). Valid values: `io1`, Default: `io1` | `string` | `"io1"` | no |
| <a name="input_subnet_group"></a> [subnet\_group](#input\_subnet\_group) | Name of the DB subnet group for the DB cluster | `any` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet within the specified subnet group | `any` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the subnet within the specified subnet group | `any` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the Virtual Private Cloud (VPC) to deploy the DB cluster | `any` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the Virtual Private Cloud (VPC) to deploy the DB cluster | `string` | `""` | no |

## Outputs

No outputs.

### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
<!-- END_TF_DOCS -->
