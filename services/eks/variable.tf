variable "region" {
  type        = string
  default     = ""
  description = "Name of the region"
}

variable "k8s_version" {
  type        = string
  default     = ""
  description = "Version of the EKS cluster"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Name of the environment"
}

variable "cluster_name" {
  type        = string
  default = ""
  description = "Name of the cluster"
}

variable "vpc_id" {
  type        = string
  default = ""
  description = "vpc id for creating EKS cluster"
}

variable "subnet_id" {
  type        = list(string)
  default = []
  description = "subnet id for creating EKS cluster"
}

variable "log_types" { 
  description = "A list of the desired control plane logs to enable."  
  type        = list(string)  
  default     = []
}

variable "node_group_name" {
  type = string
  default = ""
  description = "Name of the node group"
}


variable "node_capacity_type" {
  type        = string
  default     = ""
  description = "The instance capacity type for creating EKS node group"
}

variable "node_group_min_size" {
  type        = number
  default     = null
  description = "The minimum node count for setting up EKS node group"
}

variable "node_group_max_size" {
  type        = number
  default     = null
  description = "The maximum node count for setting up EKS node group"
}

variable "node_group_desired_size" {
  type        = number
  default     = null
  description = "The desired node count for setting up EKS node group"
}

variable "instance_type" {
  type = string
  default = ""
  description = "Type of the instance"
}

variable "volume_size" {
  type    = number
  default = null
  description = "Size of the volume to attach"
}

variable "volume_type" {
  type    = string
  default = ""
  description = "Type of the volume"
}

variable "iops" {
  type    = number
  default = null
  description = "The provisioned IOPS for a storage volume"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = null
  description = "Controls whether the EKS cluster's API server endpoint should have public access. Set to true for public access and false for private access"
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = null
  description = "Controls whether the EKS cluster's API server endpoint should have private access. Set to true for private access and false for public access"
}

