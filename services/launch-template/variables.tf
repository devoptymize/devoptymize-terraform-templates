variable "region" {
  description = "The region in which to deploy the launch template"
  type        = string
  default     = null
}

variable "launch_template_name" {
  description = "Name of an  launch template to be created "
  type        = string
  default     = null 
}

variable "key_pair" {
  description = "Key name of the Key Pair to use for the instance; which can be managed using the `aws_key_pair` resource."
  type        = string
  default     = null
}


variable "instance_type" {
  description = "The type of instance based on which the EC2 will be provisioned (e.g., t2.micro, m5.large, etc.)"
  type        = string
  default     = null
}

variable "security_group_id" {
  default     = null
  type        = list(string)
  description = "The security group IDs to be attached to EC2 instances."
}

variable "iam_instance_profile" {
  default     = null
  type        = string
  description = "The IAM instance profile to be attached to EC2 instances"
}

variable "linux_device_name" {
  default     = ["/dev/sdb","/dev/sdc","/dev/sdd","/dev/sdf"]
  type        = any
  description = "The list of Linux device names for EBS volumes to be attached to the instance"
}

variable "win_device_name" {
  default     = ["xvdb","xvdc","xvdd","xvde","xvdf"]
  type        = any
  description = "The list of Windows device names for EBS volumes to be attached to the instance"
}

data "aws_ami" "example" {
  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}
variable "ami_id" {
  default     = null
  type        = string
  description = "ami id based on which the EC2 will be provisioned"
}

variable "volume_size" {
  default     = []
  type        = any
  description = "Volume sizes that need to be attached to the launch template. For example: [20, 30, 50]"
}

variable "user_data" {
  default    = ""
  type        = string
  description = "User data script to be executed when launching the instance (usually used for bootstrapping)"
}
