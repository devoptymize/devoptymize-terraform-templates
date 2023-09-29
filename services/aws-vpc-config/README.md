<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_network"></a> [network](#module\_network) | terraform-aws-modules/vpc/aws | 5.1.1 |

## Resources

| Name | Type |
|------|------|
| [aws_route.database_peering_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_peering_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_peering_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_endpoint.endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_peering_connection.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_private_subnets"></a> [database\_private\_subnets](#input\_database\_private\_subnets) | A list of database subnets CIDR inside the VPC | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | the name of the environment | `string` | `""` | no |
| <a name="input_peer_owner_id"></a> [peer\_owner\_id](#input\_peer\_owner\_id) | owner id to peer | `string` | `""` | no |
| <a name="input_peer_region"></a> [peer\_region](#input\_peer\_region) | region we want to peer | `string` | `""` | no |
| <a name="input_peer_vpc_cidr_range"></a> [peer\_vpc\_cidr\_range](#input\_peer\_vpc\_cidr\_range) | CIDR range for the VPC | `string` | `""` | no |
| <a name="input_peer_vpc_id"></a> [peer\_vpc\_id](#input\_peer\_vpc\_id) | VPC ID | `string` | `""` | no |
| <a name="input_private_dns_enabled"></a> [private\_dns\_enabled](#input\_private\_dns\_enabled) | set the private\_dns\_enabled as true for Interface or set to false for Gateway | `string` | `""` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | List of CIDR ranges for the private subnets | `list(string)` | `null` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of CIDR ranges for the public subnets | `list(string)` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `""` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | List the service to connect vpc endpoint | `string` | `""` | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | the prefix name of all created resources | `string` | `""` | no |
| <a name="input_vpc_cidr_range"></a> [vpc\_cidr\_range](#input\_vpc\_cidr\_range) | CIDR range for the VPC | `string` | `""` | no |
| <a name="input_vpc_endpoint_type"></a> [vpc\_endpoint\_type](#input\_vpc\_endpoint\_type) | set the vpc\_endpoint type as Interface or Gateway | `string` | `""` | no |

<!-- END_TF_DOCS -->