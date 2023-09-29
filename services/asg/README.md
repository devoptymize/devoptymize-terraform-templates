<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg"></a> [asg](#module\_asg) | terraform-aws-modules/autoscaling/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_notification.example_notifications](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_notification) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | Name of ASG resources created | `string` | `""` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the autoscaling group | `number` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | Name of an existing launch template to be used (created outside of this module) | `string` | `""` | no |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead. A set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing | `list(string)` | `[]` | no |
| <a name="input_load_balancing_action"></a> [load\_balancing\_action](#input\_load\_balancing\_action) | Choose a load balancer to distribute incoming traffic for your application across instances to make it more reliable and easily scalable. | `any` | `[]` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscaling group | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscaling group | `number` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | aws region | `string` | `""` | no |
| <a name="input_sns_topic"></a> [sns\_topic](#input\_sns\_topic) | SNS ARN | `any` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones` | `list(string)` | `[]` | no |

<!-- END_TF_DOCS -->