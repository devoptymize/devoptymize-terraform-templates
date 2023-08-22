################################################################################
# Load Balancer
################################################################################

variable "loadbalancer_name" {
  type = string
  description = "the name of your alb"
  default = null
}

variable "loadbalancer_type" {
  type = string
  description = "the nlb or alb"
  default = ""
}
variable "action" {
  type = string
  description = "choose the action"
  default = ""
}

variable "scheme" {
  type =  any
  default = ""
}

variable "ip_address_type" {
  type =  any
  default = ""
}

variable "region" {
    type = string
    description = ""
    default = ""
}
variable "environment" {
  description = "aws environment"
  type        = string
  default     = null 
}

variable "credential" {
  type = any
  description = "choose credentials"
  default = ""
  
}

################################################################################
# Load Balancer Network
################################################################################

variable "security_group_id" {
  type = any
  description = "security group ID's"
  default = ""
  
}
variable "vpc_name" {
  type = any
  description = "name of the vpc"
  default = ""
}
variable "vpc_id" {
  type = any
  description = "the vpc name"
  default = ""
}
variable "subnet_name" {
  type = any
  description = "subnet name"
  default = ""
  
}
variable "subnet_id" {
  type = any
  description = "subnets which you have choosen"
  default = ""
}



################################################################################
# LB Listeners
################################################################################

variable "target_group_arn" {
    type = any
    description = "name of the target groups"
    default = ""
}

variable "port" {
    type = any
    description = "mention the port number "
    default = ""
}
variable "protocol" {
  description = "The protocol of the load balancer."
  type        = string
  default     = ""
}
variable "certificate_name" {
  type = any
  description = "Name of the certificate"
  default = null
}


variable "certificate_list" {
  description = "A  certificate for https traffic"
  type        = string
  default     = null
}

  
variable "security_policy" {
  description = "security_policy"
  type        = any
  default     = null
}

variable "alpn_policy" {
  type = any
  description = "select the ALPN policy"
  default = null
  
}

