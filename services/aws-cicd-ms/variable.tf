# variables.tf

variable "aws_region" {
  type    = string
  default = ""
}

variable "environment" {
  type        = string
  description = "The name of env in which we need to provision the resources in AWS console."
  default     = ""
}


variable "stack_name" {
  type        = string
  description = "This name will be added as a prefix to all the resource names"
  default     = ""
}



variable "repository_name" {
  type        = string
  description = "Name of the AWS CodeCommit repository where your application source code is stored."
  default     = ""
}



variable "branch_name" {
  type        = string
  description = "Name of the branch in the CodeCommit repository that will be monitored for changes.Whenever changes are pushed to this branch, the pipeline will automatically start."
  default     = ""
}

variable "compute_type" {
  type        = string
  description = "Type of the build environment that CodeBuild will use to build your application."
  default     = ""
}

variable "type" {
  type        = string
  description = "Type of the build environment that CodeBuild will use to build your application."
  default     = ""
}

variable "image" {
  type        = string
  description = "The Docker image for the build environment in CodeBuild. This image will be used to run the build process for your application."
  default     = ""
}


variable "emails" {
  type    = list(string)
  description = "Email address to receive notifications via Amazon SNS (Simple Notification Service). You will receive status updates and notifications about pipeline events on this email address."
  default = []
}
