## Cloudfront on AWS using Terraform Template

- This Terraform template is designed for creating and managing Cloudfront on Amazon Web Services (AWS). Cloudfront is to improve the performance, scalability, and availability of your web applications by distributing content globally and delivering it to users from the nearest edge location. 
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 


## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |

## Modules

| Name | Type |
|------|------|
| [module_log_bucket](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest) | module |
| [module_cloudfront_s3](https://registry.terraform.io/modules/terraform-aws-modules/cloudfront/aws/latest) | module |
| [module_cloudfront_lb](https://registry.terraform.io/modules/terraform-aws-modules/cloudfront/aws/latest) | module |

## Resources

No resource

## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cdn_name"></a> [cdn\_name](#input\_alias\_name) | the name of the Cloudfront distribution | `string` | `""` | Yes |
| <a name="input_distribution_type"></a> [distribution\_type](#input\_distribution\_type) | Choose the distribution type - S3 or Load Balancer | `string` | `""` | yes |
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM ARN to secure HTTPS protocol | `string` | `""` | no |
| <a name="input_origin_shield"></a> [origin_shield](#input\_origin\_shield) | Origin Shield can help reduce the load on your origin | `string` | `""` | Yes |
| <a name="input_region"></a> [region](#input\_region) | choose the AWS Region for Origin Shield | `String` | `""` | Yes if origin shield is true |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | Extra CNAMEs (alternate domain names), if any, for this distribution. | `string` | `""` | no |
| <a name="input_comment"></a> [description](#input\_comment) | Any comments you want to include about the distribution. | `string` | `""` | no |
| <a name="input_default_cache_behavior"></a> [viewer\_protocol\_policy](#input\_default\_cache\_behavior) | Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to the origin | `string` | `""` | no |
| <a name="input_allowed_http_methods"></a> [allowed\_http\_methods](#input\_default\_cache\_behavior) | controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin | `string` | `""` | no |
| <a name="input_default_cache_behavior"></a> [viewer\_protocol\_policy](#input\_default\_cache\_behavior) | Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to the origin | `string` | `""` | no |
| <a name="input_default_root_object"></a> [compress](#input\_default\_root\_object) | Whether you want CloudFront to automatically compress certain files for this cache behavior. If so, specify true; if not, specify false | `string` | `""` | no |
| <a name="input_http_version"></a> [http\_version](#input\_http\_version) | The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2. | `string` | `""` | no |
| <a name="input_is_ipv6_enabled"></a> [ipv6](#input\_is\_ipv6\_enabled) | Whether the IPv6 is enabled for the distribution. | `string` | `""` | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | The logging configuration that controls how logs are written to your distribution (maximum one). | `any` | `{bucket     = "cloudfront-${var.cdn_name}-s3-logbucket.s3.amazonaws.com" }` | no |
| <a name="input_origin_access_control"></a> [origin\_access\_control](#input\_origin\_access\_control) | Map of CloudFront origin access control | <pre>map(object({<br>    description      = string<br>    origin_type      = string<br>    signing_behavior = string<br>    signing_protocol = string<br>  }))</pre> | <pre>{<br>  "s3": {<br>    "description": "oac for ${var.cdn_name}-cloudfront-origin",<br>    "origin_type": "s3",<br>    "signing_behavior": "always",<br>    "signing_protocol": "sigv4"<br>  }<br>}</pre> | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `""` | no |
| <a name="input_viewer_certificate"></a> [acm\_certificate\_arn](#input\_viewer\_certificate) | The SSL configuration for this distribution | `string` | `""` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. If using WAFv2, provide the ARN of the web ACL. | `string` | `""` | no |
| <a name="input_cdn_name"></a> [loadbalancer\_domainname](#input\_alias\_name) | The DNS name of your load balancer (only needed for Load Balancer distribution) | `string` | `""` | Yes |
| <a name="input_cdn_name"></a> [bucket\_name](#input\_alias\_name) | The name of your S3 bucket (only needed for S3 distribution) | `string` | `""` | Yes |
