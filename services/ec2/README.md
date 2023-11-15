# EC2 


## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.16.2|

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2"></a> [ec2](#module\_ec2) | terraform-aws-modules/ec2-instance/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.ebs_volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_volume_attachment.volume_attachement](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_ami.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_subnet.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_volume_size"></a> [additional\_volume\_size](#input\_additional\_volume\_size) | aws ebs\_devices\_size | `any` | `""` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | ID of AMI to use for the instance | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | aws environment | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name to be used on EC2 instance created | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of instance to start | `string` | `""` | no |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Key name of the Key Pair to use for the instance | `string` | `null` | no |
| <a name="input_linux_device_name"></a> [linux\_device\_name](#input\_linux\_device\_name) | aws linux\_devices\_name | `any` | <pre>[<br>  "/dev/sdb",<br>  "/dev/sdc",<br>  "/dev/sdd",<br>  "/dev/sdf"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | aws region | `string` | `""` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | aws root\_volume\_size | `any` | `""` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | The security group ids to attach to EC2 | `any` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The VPC Subnet ID to launch in | `string` | `""` | no |
| <a name="input_win_device_name"></a> [win\_device\_name](#input\_win\_device\_name) | aws windows\_devices\_name | `any` | <pre>[<br>  "xvdb",<br>  "xvdc",<br>  "xvdd",<br>  "xvde",<br>  "xvdf"<br>]</pre> | no |

## Outputs

No outputs.



### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
<!-- END_TF_DOCS -->
