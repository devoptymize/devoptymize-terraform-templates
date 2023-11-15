variable "rds_cluster_identifier" {
  description = "The name of your DB cluster"
  type        = string
  default     = ""
}
variable "region" {
  type        = string
  description = "choose the region where the RDS to create"
  default     = ""
}
variable "engine_type" {
    type        = string
    description = "Choose the  database engine type for the RDS cluster"
    default     = ""
}
variable "engine_version" {
    type        = string
    description = "Choose the database engine version for the RDS cluster"
    default     = ""
}
variable "db_master_username" {
    type        = any
    description = "Master username for the DB cluster"
    default     = ""
}
variable "db_master_password" {
    type = any
    description = "Master Password for the DB cluster"
    default = ""
}
variable "db_instance_class" {
    type = any 
    description = "The instance class of the DB instances within the cluster"
    default = ""
}
variable "vpc_name" {
    type = string
    description = "Name of the Virtual Private Cloud (VPC) to deploy the DB cluster"
    default = ""
}
variable "vpc_id" {
    type = any
    description = "The ID of the Virtual Private Cloud (VPC) to deploy the DB cluster"
    default = ""
}
variable "subnet_group" {
    type = any
    description = "Name of the DB subnet group for the DB cluster"
    default = ""
}
variable "subnet_name" {
  type = any
  description = "Name of the subnet within the specified subnet group"
  default = ""
}
variable "subnet_id" {
    type = any
    description = "The ID of the subnet within the specified subnet group"
    default = ""
}

variable "security_group_name" {
    type = string
    description = "Name of the security group for the DB cluster"
    default = ""
}
variable "security_group_id" {
    type = list(string)
    description = "The IDs of the security groups for the DB cluster"
    default = []
}
variable "public_access" {
    type = string
    description = "Determines if the DB instances should have public access"
    default = ""
}
variable "db_instance_one" {
    type = any 
    description = "Identifier for the first DB instance (if not using default settings)"
    default = ""
}
variable "db_instance_one_custom" {
    type = any
    description = "Custom settings for the first DB instance (if not using default settings)"
    default = null

}
variable "db_instance_two" {
    type = any 
    description = "Identifier for the second DB instance (if not using default settings)"
    default = ""
}
variable "db_instance_two_custom" {
    type = any
    description = "Custom settings for the second DB instance (if not using default settings)"
    default = null

}
variable "db_instance_three" {
    type = any 
    description = "Identifier for the third DB instance (if not using default settings)"
    default = ""
}
variable "db_instance_three_custom" {
    type = any 
    description = "Custom settings for the third DB instance (if not using default settings)"
    default = null
             
}
variable "rds_storage" {
    type        = number
    description = "The amount of allocated storage for the DB cluster"
    default     = null
}
variable "storage_type" {
  description = "Specifies the storage type to be associated with the DB cluster. (This setting is required to create a Multi-AZ DB cluster). Valid values: `io1`, Default: `io1`"
  type        = string
  default     = "io1"
}
variable "iops" {
  description = "The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster"
  type        = number
  default     = 1000
}
variable "encryption" {
    type = any
    description = "Encryption configuration for the DB cluster"
    default = ""
}
variable "log_exports" {
    type = string
    description = "Log types to export to CloudWatch Logs"
    default = ""
}
variable "parameter_group" {
    type = any 
    description = "Name of the parameter group"
    default = ""
}
variable "parameter_group_new" {
    type = any 
    description = "Name of a new parameter group to associate with the DB cluster"
    default = ""
}
variable "cluster_parameter_group" {
    type = any
    description = "Name of the cluster parameter group to associate with the DB cluster"
    default = ""
}
variable "cluster_parameter_group_new" {
    type = any 
    description = "Name of a new cluster parameter group to associate with the DB cluster"
    default = ""
}
variable "dbparameter_family" {
    type = any 
    description = "The DB parameter family name for the DB cluster"
    default = ""
}



