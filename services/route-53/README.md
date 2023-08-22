<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_private_zones"></a> [private\_zones](#module\_private\_zones) | terraform-aws-modules/route53/aws//modules/zones | ~> 2.0 |
| <a name="module_public_zones"></a> [public\_zones](#module\_public\_zones) | terraform-aws-modules/route53/aws//modules/zones | ~> 2.0 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hostedzonename"></a> [hostedzonename](#input\_hostedzonename) | The name of the hosted zone that you want to route traffic for. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | The region where the hosted zone needs to be provisioned | `string` | `""` | no |
| <a name="input_route53_vpcid"></a> [route53\_vpcid](#input\_route53\_vpcid) | To use this hosted zone to resolve DNS queries for one or more VPCs, choose the VPCs. To associate a VPC with a hosted zone when the VPC was created using a different AWS account, you must use a programmatic method, such as the AWS CLI | `list(string)` | `[]` | no |

<!-- END_TF_DOCS -->