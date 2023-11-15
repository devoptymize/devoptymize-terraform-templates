################################################################################
# Load Balancer
################################################################################

variable "loadbalancer_name" {
  type = string
  description = "The name of your load balancer"
  default = ""
}

variable "loadbalancer_type" {
  type = string
  description = "The type of the load balancer to create (nlb or alb)"
  default = ""
}
variable "action" {
  type = string
  description = "Choose the action for the load balancer"
  default = ""
}

variable "scheme" {
  type =  any
  default = ""
  description = "The load balancer scheme (internet-facing or internal)"
}

variable "ip_address_type" {
  type =  any
  default = ""
  description = "The IP address type of the load balancer (ipv4 or dualstack)"
}

variable "region" {
    type = string
    description = "The AWS region where the resources will be provisioned"
    default = ""
}
variable "environment" {
  description = "The AWS environment (e.g., dev, prod)"
  type        = string
  default     = "" 
}

variable "credential" {
  type = any
  description = "choose the credentials"
  default = ""
  
}

################################################################################
# Load Balancer Network
################################################################################

variable "security_group_id" {
  type = list(string)
  description = "List of security group IDs associated with the load balancer"
  default = []
  
}
variable "vpc_name" {
  type = any
  description = "The name of the vpc"
  default = ""
}
variable "vpc_id" {
  type = any
  description = "The id for the Vpc"
  default = ""
}
variable "subnet_name" {
  type = any
  description = "The name of the subnet"
  default = ""
  
}
variable "subnet_id" {
  type = list(string)
  description = "The list of subnet IDs where the load balancer will be deployed"
  default = []
}



################################################################################
# LB Listeners
################################################################################

variable "target_group_arn" {
    type = any
    description = "The ARN of the target group for the listeners"
    default = ""
}

variable "port" {
    type = any
    description = "mention the port number"
    default = ""
}
variable "protocol" {
  description = "The protocol of the load balancer listener"
  type        = string
  default     = ""
}
variable "certificate_name" {
  type = any
  description = "Name of the SSL certificate"
  default = null
}


variable "certificate_list" {
  description = "The ARN of the SSL certificate for HTTPS traffic"
  type        = string
  default     = null
}

  
variable "security_policy" {
  description = "The security policy for SSL connections"
  type        = any
  default     = null
}

variable "alpn_policy" {
  type = any
  description = "select the ALPN policy"
  default = null
  
}

