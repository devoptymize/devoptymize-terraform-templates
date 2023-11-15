## AWS RDS using terraform template 
- This Terraform scripts are used to create RDS in AWS cloud.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code

## Installation
Dependencies to create the AWS resource using Terraform:
- Make sure Terraform is installed.

## Modules

| Name                        | Source                        | Version |
|-----------------------------|-------------------------------|---------|
| <a name="module_db"></a> [db](#module\_db) | terraform-aws-modules/rds/aws | n/a     |


## Inputs

| Name                                       | Description | Type     | Default                             | Required |
|--------------------------------------------|-------------|----------|-------------------------------------|:--------:|
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | The instance type of the RDS instance | `string` | `""` | no |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.<br>  The password provided will not be used if the variable create\_random\_password is set to true. | `string` | `""` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | Username for the master DB user | `string` | `""` | no |
| <a name="input_dbparameter_family"></a> [dbparameter\_family](#input\_dbparameter\_family) | The family of the DB parameter group | `string` | `""` | no |
| <a name="input_encryption"></a> [encryption](#input\_encryption) | rds storage encryption. Master key IDs and aliases appear in the list after they have been created using the AWS Key Management Service console. If encryption is not required select null. | `string` | `""` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | The database engine to use | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The engine version to use | `string` | `""` | no |
| <a name="input_log_exports"></a> [log\_exports](#input\_log\_exports) | Select yes if u need to export logs to cloudwatch | `string` | `""` | no |
| <a name="input_multi_az_deployment"></a> [multi\_az\_deployment](#input\_multi\_az\_deployment) | Specifies if the RDS instance is multi-AZ | `string` | `""` | no |
| <a name="input_option_group"></a> [option\_group](#input\_option\_group) | Name of the option group | `string` | `""` | no |
| <a name="input_option_group_new"></a> [option\_group\_new](#input\_option\_group\_new) | A list of Options to apply | `any` | <pre>[<br>  [<br>    "option_name = \"MARIADB_AUDIT_PLUGIN\"",<br>    "option_settings = [",<br>    "{",<br>    "name  = \"SERVER_AUDIT_EVENTS\"",<br>    "value = \"CONNECT\"",<br>    "},",<br>    "{",<br>    "name  = \"SERVER_AUDIT_FILE_ROTATIONS\"",<br>    "value = \"37\"",<br>    "},",<br>    "]",<br>    "}"]</pre> | no |
| <a name="input_parameter_group"></a> [parameter\_group](#input\_parameter\_group) | Name of the DB parameter group to associate or create | `string` | `""` | no |
| <a name="input_parameter_group_new"></a> [parameter\_group\_new](#input\_parameter\_group\_new) | Enter the parameters with the value to create the new parameter group. | `any` | <pre>[<br>  [<br>    "character_set_project",<br>    "utf8mb4"<br>  ],<br>  [<br>    "character_set_server",<br>    "utf8mb4"<br>  ]<br>]</pre> | no |
| <a name="input_public_access"></a> [public\_access](#input\_public\_access) | Bool to control if instance is publicly accessible | `string` | `""` | no |
| <a name="input_rds_name"></a> [rds\_name](#input\_rds\_name) | The name of the RDS instance | `string` | `""` | no |
| <a name="input_rds_storage"></a> [rds\_storage](#input\_rds\_storage) | The allocated storage in gigabytes | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | List of VPC security groups to associate | `list(string)` | `[]` | no |
| <a name="input_subnet_group"></a> [subnet\_group](#input\_subnet\_group) | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | A list of VPC subnet IDs | `list(string)` | `[]` | no |

## Outputs

### Usage

Once the Variable and the Module is ready follow the below commands to create the resource
- `terraform init` to download the modules
- `terraform plan` to generate an execution plan for your infrastructure.
- `terraform apply` to apply the changes and create the infrastructure.
- `terraform destroy` to delete the resource which is created through terraform.
