variable "region" {
  description = "The AWS region where the resources will be deployed"
  type        = string
  default     = ""
}

variable "vpc_production_cidr" {
  description = "CIDR block for the Production VPC"
  type        = string
  default     = ""
}
variable "production_private_cidr" {
  description = "CIDR block for the Production Private Subnet"
  type        = list(string)
  default     = [""]
}

variable "production_public_cidr" {
  description = "CIDR block for the Production Private Subnet"
  type        = list(string)
  default     = [""]
}

variable "production_isolated_cidr" {
  description = "CIDR block for the Production Isolated Subnet"
  type        = list(string)
  default     = [""]
}

variable "vpc_management_cidr" {
  description = "CIDR block for the Management VPC"
  type        = string
  default     = ""
}
variable "management_private_cidr" {
  description = "CIDR block for the Management Private Subnet"
  type        = list(string)
  default     = [""]
}

variable "management_public_cidr" {
  description = "CIDR block for the Management Public Subnet"
  type        = list(string)
  default     = [""]
}

variable "vpc_development_cidr" {
  description = "CIDR block for the Development VPC"
  type        = string
  default     = ""
}
variable "development_private_cidr" {
  description = "CIDR block for the Development Private Subnet"
  type        = list(string)
  default     = [""]
}

variable "development_public_cidr" {
  description = "CIDR block for the Development Public Subnet"
  type        = list(string)
  default     = [""]
}

variable "development_isolated_cidr" {
  description = "CIDR block for the Development Isolated Subnet"
  type        = list(string)
  default     = [""]
}

variable "server_certification" {
  description = "The Amazon Resource Name (ARN) of the server certificate."
  type        = string
  default     = ""
}
variable "clientcidrblock" {
  description = "The CIDR range for your VPC"
  type        = string
  default     = ""
}
variable "clientrootcertificate" {
  description = "The Amazon Resource Name (ARN) of the client's root certificate chain"
  type        = string
  default     = ""
}
variable "aws_configrules" {
  description = "The aws_configrules variable allows you to specify a list of AWS Config rules or configurations within your infrastructure code."
  type        = string
  default     = ""
}
