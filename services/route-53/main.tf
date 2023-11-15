module "private-hosted-zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  count = var.route53_vpcid == [] ? 0 : 1
  zones = {
    "${var.hostedzonename}" = {
      comment = var.hostedzonename
      tags = {
        Name = var.hostedzonename
      }
      vpc = [
        for vpc_id in var.route53_vpcid : {
          vpc_id     = vpc_id
          vpc_region = var.region
        }
      ]
    }
  }
}


module "public-hosted-zones" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"
  count   = var.route53_vpcid == [] ? 1 : 0
  zones = {
    "${var.hostedzonename}" = {
      comment = var.hostedzonename
      tags = {
        Name = var.hostedzonename
      }
    }
  }
}
