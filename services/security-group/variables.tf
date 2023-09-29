#################
# Security group
#################
variable "region" {
  description = "the region in which to deploy resources"
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Name of security group"
  type        = string
  default     = null
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
  default     = null
}

variable "description" {
  description = "Description for the security group"
  type        = string
  default = ""
}

##########
# Ingress
##########
variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  default = []
  type = any
}

