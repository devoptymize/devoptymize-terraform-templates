## Network ##

variable "environment" {
  description = "The environment name for the infrastructure"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "The stack_name name for the infrastructure"
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

variable "app_subnets" {
  description = "A list of private subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}

variable "data_subnets" {
  description = "A list of database subnets CIDR inside the VPC"
  type        = list(string)
  default     = []
}

### security group##


variable "ingressrules" {
  description = "List of ingress rules to create"
  default = ""
  type = any
}

## launch template

variable "key_pair" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource"
  type        = string
  default = ""
}

variable "instance_type" {
  description = "The type of instance"
  type        = string
  default     = ""
}

variable "ami_id" {
  default     = ""  
  type        = string
  description = "ami id"
}

variable "volume_size" {
  type    = number
  description = "List of volume sizes"
  default = null
}
  
variable "volume_type" {
  description = "volume type"
  type        = string
  default     = ""
}

### Auto-scaling group

variable "asg_min_size" {
  description = "minimum size of auto-scaling"
  type        = number
  default     = null
}

variable "asg_max_size" {
  description = "minimum size of auto-scaling"
  type        = number
  default     = null
}

variable "asg_desired_capacity" {
  description = "minimum size of auto-scaling"
  type        = number
  default     = null
}

#### EFS

variable "kms_key_id" {
  description = "The arn for the KMS key"
  type        = string
  default     = ""
}

variable "performance_mode" {
  description = "Select the performance mode of the file system."
  type        = string
  default     = ""
}

variable "encrypted_boolean" {
  description = "Create an encrypted Amazon EFS file system."
  type        = bool
  default     = null
}

variable "throughput_mode" {
  description = "Specifies the throughput mode for the file system. The mode can be bursting, provisioned, or elastic."
  type        = string
  default     = ""
}

variable "provisioned_throughput_mibps" {
  description = "The throughput, measured in mebibytes per second (MiBps), that you want to provision for a file system that you're creating.(Required if ThroughputMode is set to provisioned)."
  type        = number
  default     = null
}

#### ELASTICLUSTER

variable "number_of_subnets" {
  description = "Select the number of subnets ."
  type        = number
  default     = null
}

variable "elasticache_node_type" {
  description = " Node type of the elasticache"
  type        = any
  default     = ""
}

#### RDS Cluster
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
variable "log_exports" {
    type = string 
    description = "Enable log exports to CloudWatch"
    default = ""
}

## Cloudfront ##
variable "acm_certificate_arn_cloudfront" {
  description = "The acm certificate ARN "
  type = string
  default = "" 
}
## ALB ##
variable "acm_certificate_arn_alb" {
  description = "The acm certificate ARN "
  type = string
  default = ""
  
}

### Route53 ###
variable "domain_name" {
  description = "domain name for the application"
  type        = string
  default = ""  
}
variable "hosted_zone_id" {
  description = "The id of the route53 zone"
  type = string
  default = ""
}


