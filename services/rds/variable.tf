variable "region" {
    type = string
    description = ""
    default = ""
}
variable "rds_name" {
  description = "The name of the RDS instance"
  type        = string
  default = ""
}

variable "rds_storage" {
  description = "The allocated storage in gigabytes"
  type        = string
  default     = ""
}

variable "engine_type" {
  description = "The database engine to use"
  type        = string
  default     = ""
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = ""
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = ""
}


variable "db_master_username" {
  description = "Username for the master DB user"
  type        = string
  default     = ""
}

variable "db_master_password" {
  description = <<EOF
  Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file.
  The password provided will not be used if the variable create_random_password is set to true.
  EOF
  type        = string
  default     = ""
  sensitive   = true
}

variable "security_group_id" {
  description = "List of VPC security groups to associate"
  type        = list(string)
   default     = []
}


variable "multi_az_deployment" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = string
  default     = ""
}


variable "public_access" {
  description = "Bool to control if instance is publicly accessible"
  type        = string
  default     = ""
}

# DB subnet group
variable "subnet_group" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     =  ""
}

variable "subnet_id" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

# DB parameter group
variable "parameter_group" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = ""
}

variable "dbparameter_family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = ""
}

variable "parameter_group_new" {
  description = "Enter the parameters with the value to create the new parameter group."
  type        = any
  default     = [["character_set_project","utf8mb4"],["character_set_server","utf8mb4"]]
}

# DB option group
variable "option_group" {
  description = "Name of the option group"
  type        = string
  default     = ""
}
variable "option_group_new" {
  description = "A list of Options to apply"
  type        = any
  default     = <<EOT
                {
                    option_name = "MARIADB_AUDIT_PLUGIN"

                    option_settings = [
                        {
                        name  = "SERVER_AUDIT_EVENTS"
                        value = "CONNECT"
                        },
                        {
                        name  = "SERVER_AUDIT_FILE_ROTATIONS"
                        value = "37"
                        },
                    ]
                    },
             EOT
}

#ENCRYPTION
variable "encryption" {
  description = "rds storage encryption. Master key IDs and aliases appear in the list after they have been created using the AWS Key Management Service console. If encryption is not required select null. "
  type        = string
  default     = ""
}

# logs
variable "log_exports" {
  description = "Select yes if u need to export logs to cloudwatch "
  type        = string
  default     = ""
}

