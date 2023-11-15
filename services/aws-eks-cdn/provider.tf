provider "aws" {
    region = var.region
    
    default_tags {
      tags = { 
               Terraform   = "True"
               stack     = var.stack_name

               
               
      }
}
}
