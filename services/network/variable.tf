variable "region" {
  description = "the region in which to deploy resources"
  type        = string
  default     = ""
}
variable "vpc_name" {
  description = "the name of your vpc"
  type        = string
  default     = ""
}
variable "vpc_cidr_range" {
  description = "cidr range for your vpc"
  type        = string
  default     = ""
}
variable "public_subnets" {
  default     = null
  type        = list(string)
  description = "A list of public subnets CIDR inside the VPC"
}
variable "private_subnets" {
   default     = null
  type        = list(string)
  description = "A list of private subnets CIDR inside the VPC"
}
# Gets all the AZ's in the region
data "aws_availability_zones" "available" {
    state = "available"
}

locals {
    availability_zones = data.aws_availability_zones.available.names
}

