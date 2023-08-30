## Network ##
variable "environment" {
  description = "The environment in which we need to provision infrastructure"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "This name will be the prefix to all the resources getting created"
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region where the resources will be deployed"
  type        = string
  default     = ""
}

variable "vpc_cidr_range" {
  description = "The CIDR range for your VPC"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "A list of public subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}

variable "database_private_subnets" {
  description = "A list of database subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}


### security group##

variable "ingressrules" {
  description = "List of inbound rule for the security group"
  default = ""
  type = any
}


## launch template

variable "key_pair" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "ami_id" {
  default     = ""
  type        = string
  description = "The ID of the AMI to use for the instance"
}

variable "volume_size" {
  type    = number
  description = "Size of volume to attach to the instance"
  default = null
}
  
variable "volume_type" {
  description = "Type of the volume. eg gp2,gp3"
  type        = string
  default     = ""
}

### Auto-scaling group

variable "asg_min_size" {
  description = "Minimum size of auto-scaling group"
  type        = number
  default     = null
}

variable "asg_max_size" {
  description = "Maximum size of auto-scaling group"
  type        = number
  default     = null
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
  default     = null
}

#### RDS Cluster###

variable "rds_cluster_identifier" {
  description = "The name of your DB cluster"
  type        = string
  default     = ""
}

variable "engine_type" {
    type = string
    description = "choose the engine type"
    default = ""
}
variable "engine_version" {
    type = any
    description = "choose the engine version"
    default = ""
}
variable "db_master_username" {
    type = any
    description = "The username of rds"
    default = ""
}
variable "allocated_storage" {
    type = number
    description = "The allocated storage for the rds"
    default = null
}
variable "db_master_password" {
    type = any
    description = "The password of rds"
    default = ""
}
variable "db_instance_class" {
    type = any 
    description = "The AWS RDS instance class for the database"
    default = ""
}

###### Load Balancer

variable "acm_certificate_arn_alb" {
  description = "The acm certificate arn for the domain "
  type = string
  default = ""
}

## Cloudfront###

variable "domain_name" {
  description = "The name of the domain"
  type        = string
  default = ""  
}

variable "acm_certificate_arn_cloudfront" {
  description = "The acm certificate arn for the domain "
  type = string
  default = ""
}

## Route53 ##

variable "hosted_zone_id" {
  description = "The ID of the hosted zone in Route53"
  type = string
  default = ""
}
