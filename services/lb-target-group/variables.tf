variable "target_group_name" {
  description = "Name of the target group. A maximum of 32 alphanumeric characters including hyphens are allowed, but the name must not begin or end with a hyphen"
  type        = string
  default     = ""
}

variable "target_type" {
  description = "The list of the target type"
  type        = string
  default     = ""
}

variable "port_number" {
  description = "The number of port on which targets receive traffic, unless overridden when registering a specific target. Valid values are either ports 1-65535"
  type        = string
  default     = ""
}

variable "protocol_type" {
  description = "The type of the protocol"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "Select the VPC with the instances that you want to include in the target group"
  type        = string
  default     = ""
}

variable "lambda_function_arn" {
  description = "The Lambda function which needs to be attached to the target group"
  type        = string
  default     = ""
}
variable "ec2_id" {
  description = "The ID of the EC2 instance which needs to be attached"
  type        = list(string)
  default     = []
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
  default     = ""
}

variable "region" {
  description = "The region where the target group will be created"
  type        = string
  default     = ""
}

variable "ip_address" {
  description = "The targets are specified by IP addresses"
  type        = list(string)
  default     = []
}

variable "application_load_balancer" {
  description = "The targets are specified by Application Load Balancer"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "The name of the instance which needs to be attached to the target group"
  type        = string
  default     = ""
}
