variable "cdn_name" {
  description = "the name of the Cloudfront Distribution"
  type        = string
  default     = ""
}

variable "distribution_type" {
  description = "Choose the distribution type - S3 or Load Balancer"
  type        = string
  default     = ""
}

variable "acm_certificate_arn" {
  description = "ACM ARN to secure HTTPS protocol"
  type        = string
  default     = ""
}

variable "origin_shield" {
  description = "Origin Shield can help reduce the load on your origin."
  type        = string
  default     = ""
}

variable "region" {
  description = "choose the AWS Region for Origin Shield"
  type        = string
  default     = ""
}

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution."
  type        = string
  default     = ""
}

variable "price_class" {
  description = "The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100"
  type        = string
  default     = ""
}

variable "viewer_protocol_policy" {
  description = "Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to the origin"
  type        = string
  default     = ""
}

variable "compress" {
  description = "Whether you want CloudFront to automatically compress certain files for this cache behavior. If so, specify true; if not, specify false"
  type        = string
  default     = ""
}

variable "ipv6" {
  description = "If you want CloudFront to respond to IPv6 DNS requests with an IPv6 address for your distribution, specify true. If you specify false, CloudFront responds to IPv6 DNS requests with the DNS response code NOERROR and with no IP addresses."
  type        = string
  default     = ""
}

variable "description" {
  description = "A comment to describe the distribution. The comment cannot be longer than 128 characters."
  type        = string
  default     = ""
}

variable "allowed_http_methods" {
  description = "controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin"
  type        = any
  default = []
}

variable "origin_path" {
  description = "An optional path that CloudFront appends to the origin domain name when CloudFront requests content from the origin"
  type        = string
  default     = ""
}

variable "webacl_id" {
  description = "A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution."
  type        = string
  default     = ""
}

variable "default_root_object" {
  description = "The object that you want CloudFront to request from your origin (for example, index.html)"
  type        = string
  default     = ""
}

variable "http_version" {
  description = " The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2."
  type        = string
  default     = ""
}

variable "origin_protocol_policy" {
  description = "Specifies the protocol (HTTP or HTTPS) that CloudFront uses to connect to the origin"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Specified the environment in which our resource has to be created"
  type        = string
  default     = ""
}

variable "loadbalancer_domainname" {
  description = "The DNS name of your load balancer (only needed for Load Balancer distribution)"
  type        = string
  default     = ""
}

variable "bucket_name" {
  description = "The name of your S3 bucket (only needed for S3 distribution)"
  type        = string
  default     = ""
}


