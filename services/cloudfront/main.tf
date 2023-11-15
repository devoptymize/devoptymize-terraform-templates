
data "aws_canonical_user_id" "current" {}
data "aws_cloudfront_log_delivery_canonical_user_id" "cloudfront" {}

# The following block will create S3 resource
module "log_bucket" {
  source                   = "terraform-aws-modules/s3-bucket/aws"
  version                  = "~> 3.0"
  bucket                   = "cloudfront-${var.cdn_name}-s3-logbucket"
  acl                      = null
  control_object_ownership = true
  object_ownership         = "ObjectWriter"
  force_destroy = true
}

# The following block will create cloudfront resource
module "cloudfront_s3" {
  source                       = "terraform-aws-modules/cloudfront/aws"
  version                      = "3.2.0"
  count                        = var.distribution_type == "S3" ? 1 : 0
  aliases                      = ["${var.aliases}"]
  comment                      = var.description
  web_acl_id                   = var.webacl_id
  enabled                      = true
  is_ipv6_enabled              = var.ipv6
  price_class                  = var.price_class
  http_version                 = var.http_version
  retain_on_delete             = false
  wait_for_deployment          = false
  create_origin_access_control = true
  origin_access_control = {
    "${var.cdn_name}-cloudfront-origin" = {
      description      = "oac for ${var.cdn_name}-cloudfront-origin"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  logging_config = {
    bucket     = "cloudfront-${var.cdn_name}-s3-logbucket.s3.amazonaws.com" 
    depends_on = [module.log_bucket]
    }

  origin = {
    "${var.cdn_name}-cloudfront-origin" = {
      origin_shield = {
        enabled              = var.origin_shield
        origin_shield_region = var.region
      }
      domain_name           = "${var.bucket_name}.s3.amazonaws.com"
      origin_access_control = "${var.cdn_name}-cloudfront-origin" 
    }
  }
  default_cache_behavior = {
    path_pattern           = "/*"
    target_origin_id       = "${var.cdn_name}-cloudfront-origin"
    viewer_protocol_policy = var.viewer_protocol_policy
    allowed_http_methods   = var.allowed_http_methods
    cached_methods         = ["GET", "HEAD"]
    compress               = var.compress
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    use_forwarded_values   = false
  }
  viewer_certificate = {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    ssl_support_method  = "sni-only"
  }
  default_root_object = var.default_root_object
  custom_error_response = [{
    error_code         = 404
    response_code      = 404
    response_page_path = "/index.html"
    },
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/index.html"
  }]
  tags = {
    purpose = "CF distribution"
  }
}

module "cloudfront_lb" {
  source                       = "terraform-aws-modules/cloudfront/aws"
  version                      = "3.2.0"
  count                        = var.distribution_type == "Loadbalancer" ? 1 : 0
  aliases                      = ["${var.aliases}"]
  comment                      = var.description
  web_acl_id                   = var.webacl_id
  enabled                      = true
  is_ipv6_enabled              = var.ipv6
  price_class                  = var.price_class
  http_version                 = var.http_version
  retain_on_delete             = false
  wait_for_deployment          = false
  create_origin_access_control = false

  logging_config = {
    bucket     = "cloudfront-${var.cdn_name}-s3-logbucket.s3.amazonaws.com" 
    depends_on = [module.log_bucket]
    }
  origin = {
    "${var.cdn_name}-cloudfront-origin" = {
      domain_name = var.loadbalancer_domainname
      origin_shield = {
        enabled              = var.origin_shield
        origin_shield_region = var.region
      }
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = var.origin_protocol_policy
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }
  }
  default_cache_behavior = {
    path_pattern           = "/*"
    target_origin_id       = "${var.cdn_name}-cloudfront-origin"
    viewer_protocol_policy = var.viewer_protocol_policy
    allowed_methods        = var.allowed_http_methods
    cached_methods         = ["GET", "HEAD"]
    compress               = var.compress
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    use_forwarded_values   = false
  }
  viewer_certificate = {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    ssl_support_method  = "sni-only"
  }

  default_root_object = var.default_root_object
  custom_error_response = [{
    error_code         = 404
    response_code      = 404
    response_page_path = "/index.html"
    },
    {
      error_code         = 403
      response_code      = 403
      response_page_path = "/index.html"
  }]
  tags = {
    purpose = "CF distribution"
  }
}



