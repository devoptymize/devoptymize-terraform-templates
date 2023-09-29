################################################################################
# Autoscaling group
################################################################################
variable "region" {
  description = "aws region"
  type        = string
  default     = "" 
}

variable "asg_name" {
  description = "Name of ASG resources created"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with `availability_zones`"
  type        = list(string)
  default     = []
}

variable "min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
  default     = null
}

variable "max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
  default     = null
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the autoscaling group"
  type        = number
  default     = null
}

variable "load_balancer" {
  description = "A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead. A set of `aws_alb_target_group` ARNs, for use with Application or Network Load Balancing"
  type        = list(string)
  default     = []
}

variable "load_balancing_action" {
  description = "Choose a load balancer to distribute incoming traffic for your application across instances to make it more reliable and easily scalable."
  type        = any
  default     = []
}


################################################################################
# Launch template
################################################################################
 variable "launch_template" {
  description = "Name of an existing launch template to be used (created outside of this module)"
  type        = string
  default     = ""
}

################################################################################
# SNS Notification
################################################################################

 variable "sns_topic" {
  description = "SNS ARN"
  type        = any
  default     = ""
}
