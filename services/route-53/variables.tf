variable "hostedzonename" {
  default     = ""
  type        = string
  description = "The name of the hosted zone that you want to route traffic for."
}

variable "route53_vpcid" {
  default = []
  type        = list(string)
  description = "To use this hosted zone to resolve DNS queries for one or more VPCs, choose the VPCs. To associate a VPC with a hosted zone when the VPC was created using a different AWS account, you must use a programmatic method, such as the AWS CLI"
}

variable "region" {
  default     = ""
  type        = string
  description = "The region where the hosted zone needs to be provisioned"
}
