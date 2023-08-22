# Gets all the AZ's in the region
data "aws_availability_zones" "available" {
    state = "available"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "the prefix name of all created resources"
  type        = string
  default     = ""
  
}

variable "environment" {
  description = "the name of the environment"
  type = string
  default = ""
}
  
variable "vpc_cidr_range" {
  description = "CIDR range for the VPC"
  type        = string
  default = ""
}

variable "public_subnets" {
  description = "List of CIDR ranges for the public subnets"
  type        = list(string)
  default     = null
}

variable "private_subnets" {
  description = "List of CIDR ranges for the private subnets"
  type        = list(string)
  default     = null
}

variable "database_private_subnets" {
  description = "A list of database subnets CIDR inside the VPC"
  type        = list(string)
  default     = null
}

#########################
### endpoint ############
#########################

variable "service_name" {
  description = "List the service to connect vpc endpoint"
  type = string
  default = ""
  
}

variable "vpc_endpoint_type" {
  description = "set the vpc_endpoint type as Interface or Gateway"
  type = string
  default = ""
  
}

variable "private_dns_enabled" {
  description = "set the private_dns_enabled as true for Interface or set to false for Gateway"
  type = string
  default = ""
  
}

######################
#### Peering #########
######################

variable "peer_vpc_cidr_range" {
  description = "CIDR range for the VPC"
  type        = string
  default = ""
}

variable "peer_vpc_id" {
  description = " VPC ID"
  type        = string
  default = ""
}

variable "peer_owner_id" {
  description = "owner id to peer"
  type = string
  default = ""
}
variable "peer_region" {
  description = "region we want to peer"
  type = string
  default = ""
  
}
