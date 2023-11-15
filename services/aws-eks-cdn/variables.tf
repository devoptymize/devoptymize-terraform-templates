######################### Network ##############################

variable "environment" {
  description = "the name of the environment"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "the name of the stack"
  type        = string
  default     = ""
}

variable "region" {
  description = "the region in which to deploy resources"
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



##################################### EKS ########################################


variable "cluster_version" {
  type = string
  description = "Enter the version of your EKS cluster"
  default = ""
}
variable "eks_node_group_min_size" {
    type = number
    description = "minimum size of the eks node"
    default = null
}
variable "eks_node_group_max_size" {
    type = number
    description = "maximum size of the eks node"
    default = null
}
variable "eks_node_group_desired_size" {
    type = number
    description = "Desired size of the eks node"
    default = null
}
variable "eks_node_group_instance_types" {
    type = list(string)
    description = "Type of the node group instance to be"
    default = []
}
variable "eks_node_group_capacity_type" {
    type = string
    description = "Capacity of the node group instance to be"
    default = ""
}


################################### RDS ######################################



variable "engine_type" {
    type = string
    description = "The engine type for DB"
    default = "postgres"
}
variable "engine_version" {
    type = any
    description = "The engine version for DB"
    default = ""  
}
variable "db_instance_class" {
    type = any 
    description = "the type of the instance DB class"
    default = ""
}

variable "db_master_username" {
  type = string
  description = "username for db"
  default = ""
}
variable "db_master_password" {
  type = string
  description = "password for db"
  default = ""
}
variable "rds_storage" {
    type = number
    description = "The storage of the DB instance"
    default = 0
}



################################# S3 CDN WAF R53 ############################################



variable "cdn_aliases" {
  description = "The aliases name"
  type        = list(string)
  default = []  
}

variable "acm_certificate_arn" {
  description = "ARN of the certificate"
  type = string
  default = ""
}



variable "hosted_zone_id" {
  description = "The id of the route53 zone"
  type = string
  default = ""
}






