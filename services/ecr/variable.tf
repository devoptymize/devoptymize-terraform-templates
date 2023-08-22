variable "ecr_repo_name" {
  description = "Provide a concise name. A developer should be able to identify the repository contents by the name."
  type        = string
  default     = ""
}

variable "region" {
  description = "The AWS region where the ECR will be created"
  type        = string
  default     = ""
}

variable "read_access_arns" {
  description = "Select the appropriate users arn who can have read access to ecr repo"
  type        = list(string)
  default     = []
}

variable "read_write_access_arns" {
  description = "Select the appropriate users arn who can have read and write access to ecr repo"
  type        = list(string)
  default     = []
}

variable "repository_image_tag_mutability" {
  description = "Enable tag immutability to prevent image tags from being overwritten by subsequent image pushes using the same tag. Disable tag immutability to allow image tags to be overwritten."
  type        = string
  default     = ""
}


variable "repository_type" {
  description = "Select the type of the ECR repo. Can be either a public or private one"
  type        = string
  default     = ""
}

variable "scan_repo" {
  description = "Enable scan on push to have each image automatically scanned after being pushed to a repository. If disabled, each image scan must be manually started to get scan results."
  type        = bool
  default     = null
}

variable "image_count" {
  description = "Specify the number of images to be stored in the ECR repository."
  type        = number
  default     = null
}
