variable "key_pair_name" {
  description = "The name for the key pair. Conflicts with `key_name_prefix`"
  type        = string
  default     = null
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "" 
}
