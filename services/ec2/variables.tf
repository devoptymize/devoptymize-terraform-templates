variable "region" {
  description = "aws region"
  type        = string
  default     = "" 
}

variable "environment" {
  description = "aws environment"
  type        = string
  default     = null 
}

variable "security_group_id" {
  default     = []
  type        = any
  description = "The security group ids to attach to EC2"
}

variable "key_pair" {
  description = "Key name of the Key Pair to use for the instance"
  type        = string
  default     = null
}

variable "ami_id" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  default     = ""
  type        = any
  description = "aws root_volume_size"
} 

variable "additional_volume_size" {
  default     = ""
  description = "aws ebs_devices_size"
  type        = any
}

variable "linux_device_name" {
  default     = ["/dev/sdb","/dev/sdc","/dev/sdd","/dev/sdf"]
  type        = any
  description = "aws linux_devices_name"
}

variable "win_device_name" {
  default     = ["xvdb","xvdc","xvdd","xvde","xvdf"]
  type        = any
  description = "aws windows_devices_name"
}

data "aws_subnet" "selected" {
  id = var.subnet_id
  
} 

data "aws_ami" "example" {
  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}

