<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_launch_template.launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ami id based on which the EC2 will be provisioned | `string` | `null` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM instance profile to be attached to EC2 instances | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance based on which the EC2 will be provisioned (e.g., t2.micro, m5.large, etc.) | `string` | `null` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource. | `string` | `null` | no |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | Name of an  launch template to be created | `string` | `null` | no |
| <a name="input_linux_device_name"></a> [linux\_device\_name](#input\_linux\_device\_name) | The list of Linux device names for EBS volumes to be attached to the instance | `any` | <pre>[<br>  "/dev/sdb",<br>  "/dev/sdc",<br>  "/dev/sdd",<br>  "/dev/sdf"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which to deploy the launch template | `string` | `null` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The security group IDs to be attached to EC2 instances. | `list(string)` | `null` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to be executed when launching the instance (usually used for bootstrapping) | `string` | `""` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Volume sizes that need to be attached to the launch template. For example: [20, 30, 50] | `any` | `[]` | no |
| <a name="input_win_device_name"></a> [win\_device\_name](#input\_win\_device\_name) | The list of Windows device names for EBS volumes to be attached to the instance | `any` | <pre>[<br>  "xvdb",<br>  "xvdc",<br>  "xvdd",<br>  "xvde",<br>  "xvdf"<br>]</pre> | no |

<!-- END_TF_DOCS -->