provider "aws" {
  region = var.region
 // profile = "default"
    default_tags {
      tags = { 
               Terraform   = "True"             
            }
        }
}
