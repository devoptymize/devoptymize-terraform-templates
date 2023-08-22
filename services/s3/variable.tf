variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
  default     = ""
}

variable "bucket_policy" {
  description = "The bucket policy rules in JSON format"
  type    = any
  default = ""
}

variable "bucket_key_enabled" {
  description = "Specify whether to use an S3 Bucket Key for encryption"
  type    = bool
  default = null
}

variable "region" {
  description = "aws region"
  type        = string
  default     = "" 
}
