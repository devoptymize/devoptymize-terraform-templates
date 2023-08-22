<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb"></a> [lb](#module\_lb) | terraform-aws-modules/alb/aws | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_alb_listener.loadbalancer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | choose the action | `string` | `""` | no |
| <a name="input_alpn_policy"></a> [alpn\_policy](#input\_alpn\_policy) | select the ALPN policy | `any` | `null` | no |
| <a name="input_certificate_list"></a> [certificate\_list](#input\_certificate\_list) | A  certificate for https traffic | `string` | `null` | no |
| <a name="input_certificate_name"></a> [certificate\_name](#input\_certificate\_name) | Name of the certificate | `any` | `null` | no |
| <a name="input_credential"></a> [credential](#input\_credential) | choose credentials | `any` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | aws environment | `string` | `null` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | n/a | `any` | `""` | no |
| <a name="input_loadbalancer_name"></a> [loadbalancer\_name](#input\_loadbalancer\_name) | the name of your alb | `string` | `null` | no |
| <a name="input_loadbalancer_type"></a> [loadbalancer\_type](#input\_loadbalancer\_type) | the nlb or alb | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | mention the port number | `any` | `""` | no |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | The protocol of the load balancer. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `""` | no |
| <a name="input_scheme"></a> [scheme](#input\_scheme) | n/a | `any` | `""` | no |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | security group ID's | `any` | `""` | no |
| <a name="input_security_policy"></a> [security\_policy](#input\_security\_policy) | security\_policy | `any` | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | subnets which you have choosen | `any` | `""` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | subnet name | `any` | `""` | no |
| <a name="input_target_group_arn"></a> [target\_group\_arn](#input\_target\_group\_arn) | name of the target groups | `any` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | the vpc name | `any` | `""` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | name of the vpc | `any` | `""` | no |

<!-- END_TF_DOCS -->