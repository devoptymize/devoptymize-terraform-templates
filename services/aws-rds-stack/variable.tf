## Network ##
variable "environment" {
  description = "The environment name for the infrastructure"
  type        = string
  default     = ""
}

variable "stack_name" {
  description = "The stack name name for the stack"
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

#### rds #####

variable "rds_identifier" {
  description = "The identifier of the RDS instance"
  type        = string
  default     = ""
}

variable "storage_type" {
  description = "The storage type of the rds instance"
  type        = string
  default = ""
}

variable "engine_type" {
  description = "The type of the database engine"
  type        = string
  default     = ""
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = ""
}

variable "db_master_username" {
  description = "The master username for the RDS cluster"
  type        = string
  default     = ""
}

variable "db_master_password" {
  description = "The master password for the RDS cluster"
  type        = string
  default     = ""
}

variable "db_instance_class" {
  description = "The instance class for the RDS instances"
  type        = string
  default     = ""
}

variable "rds_storage" {
  description = "The allocated storage for the RDS instances"
  type        = string
  default     = ""
}

variable "log_exports" {
  description = "Enable CloudWatch logs exports"
  type        = string
  default     = "" 
}
### SNS Notification ###
variable "email_address" {
  type    = list(string)
  description = "Email address to receive notifications via Amazon SNS (Simple Notification Service). You will receive status updates and notifications about pipeline events on this email address."
  default = []
}



