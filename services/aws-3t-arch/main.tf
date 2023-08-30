data "aws_availability_zones" "available" {
  state = "available"
}

## Terraform module for creating the network part ##
module "network" {
source = "terraform-aws-modules/vpc/aws"
name = "${var.environment}-${var.stack_name}-vpc"
cidr   = var.vpc_cidr_range
azs                   = slice(data.aws_availability_zones.available.names, 0, 3)
# azs                   = data.aws_availability_zones.available.names
public_subnets        = var.public_subnets
private_subnets       = var.private_subnets


# Database Subnets
create_database_subnet_group = true
create_database_subnet_route_table= true
database_subnets     = var.database_private_subnets

enable_dns_hostnames    = true
enable_nat_gateway      = true
single_nat_gateway      = false  # Set to false to create NAT gateway per AZ
one_nat_gateway_per_az  = true   # Set to true to create NAT gateway per AZ

}

## Terraform script for creating the security group for private webserver ##
resource "aws_security_group" "sg_alb_bcknd" {
vpc_id      = module.network.vpc_id
name        = "${var.environment}-${var.stack_name}-sg-alb-bcknd"
description = "${var.environment}-${var.stack_name} backednd alb security group"
ingress     = local.ingressrules

egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

locals {
  ingressrules = [ for v in var.ingressrules : {  from_port = v[0], to_port = v[0] , protocol = v[1], cidr_blocks = v[2] ,security_groups = v[3] , description = "", ipv6_cidr_blocks = [], prefix_list_ids = [], self= false} ]

}

resource "aws_security_group" "sg_bcknd" {
name        = "${var.environment}-${var.stack_name}-sg-bcknd"
description = "${var.environment}-${var.stack_name}-sg-bcknd"
vpc_id      = var.vpc_id

ingress {
  description = "HTTP access"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_groups = [aws_security_group.sg_alb_bcknd.id]
}
egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}
}

## Terraform script for creating the security group for public web server ##
resource "aws_security_group" "sg_alb_frntnd" {
vpc_id      = module.network.vpc_id
name        = "${var.environment}-${var.stack_name}-sg-alb-frntnd"
description = "${var.environment}-${var.stack_name} frontend alb security group"
ingress     = local.ingressrules

egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_security_group" "sg_frntnd" {
name        = "${var.environment}-${var.stack_name}-sg-frntnd"
description = "${var.environment}-${var.stack_name}-sg-frntnd"
vpc_id      = var.vpc_id

ingress {
  description = "HTTP access"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_groups = [aws_security_group.sg_alb_frntnd.id]
}
egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}
}

## Terraform script for creating the auto scaling group for private web server ##
module "asg_backend" { 
source  = "terraform-aws-modules/autoscaling/aws"

# Autoscaling group
name = "${var.environment}-${var.stack_name}-asg-bcknd"
depends_on = [module.alb_bcknd]

min_size                  = var.asg_min_size
max_size                  = var.asg_max_size
desired_capacity          = var.asg_desired_capacity
wait_for_capacity_timeout = 0
health_check_type         = "ELB"
vpc_zone_identifier       = module.network.private_subnets
#concat(module.network.public_subnets, module.network.private_subnets)
security_groups           = [aws_security_group.sg_bcknd.id]
target_group_arns         = module.alb_bcknd.target_group_arns


# Launch template
launch_template_name        = "${var.environment}-${var.stack_name}-lt-bcknd"
launch_template_description = "${var.environment}-${var.stack_name} launch template for backend server"
update_default_version      = true

image_id          = var.ami_id
instance_type     = var.instance_type
key_name          = var.key_pair
ebs_optimized     = true
enable_monitoring = true

# IAM role & instance profile
create_iam_instance_profile = true
iam_role_name               = "${var.environment}-${var.stack_name}-asg-bcknd-role"
iam_role_path               = "/ec2/"
iam_role_description        = "${var.environment}-${var.stack_name} asg backend iam role "
iam_role_tags = {
  CustomIamRole = "Yes"
}
iam_role_policies = {
  AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
} 
block_device_mappings = [
  {
    # Root volume
    device_name = "/dev/xvda"
    no_device   = 0
    ebs = {
      delete_on_termination = true
      encrypted             = true
      volume_size           = var.volume_size
      volume_type           = var.volume_type
    }
  },
]
disable_api_termination = true
metadata_options = {
  http_endpoint               = "enabled"
  http_tokens                 = "required"
  http_put_response_hop_limit = 32
}
tags = {
  Environment = var.environment
}
}
## Terraform script for creating the asg for public web server ##
module "asg_frontend" { 
source  = "terraform-aws-modules/autoscaling/aws"

# Autoscaling group
name = "${var.environment}-${var.stack_name}-asg-frntnd"
depends_on = [module.alb_frntnd]

min_size                  = var.asg_min_size
max_size                  = var.asg_max_size
desired_capacity          = var.asg_desired_capacity
wait_for_capacity_timeout = 0
health_check_type         = "ELB"
vpc_zone_identifier       = module.network.private_subnets
security_groups           = [aws_security_group.sg_frntnd.id]
target_group_arns         = module.alb_frntnd.target_group_arns
## Launch template
launch_template_name        = "${var.environment}-${var.stack_name}-lt-frntnd"
launch_template_description = "${var.environment}-${var.stack_name} launch template for frontend servers"
update_default_version      = true

image_id          = var.ami_id
instance_type     = var.instance_type
key_name          = var.key_pair
ebs_optimized     = true
enable_monitoring = true

# IAM role & instance profile
create_iam_instance_profile = true
iam_role_name               = "${var.environment}-${var.stack_name}-asg-frntnd-role"
iam_role_path               = "/ec2/"
iam_role_description        = "${var.environment}-${var.stack_name} asg frntnd iam role "
iam_role_tags = {
  CustomIamRole = "Yes"
}
iam_role_policies = {
  AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
block_device_mappings = [
  {
    # Root volume
    device_name = "/dev/xvda"
    no_device   = 0
    ebs = {
      delete_on_termination = true
      encrypted             = true
      volume_size           = var.volume_size
      volume_type           = var.volume_type
    }
  },
]
disable_api_termination = true

metadata_options = {
  http_endpoint               = "enabled"
  http_tokens                 = "required"
  http_put_response_hop_limit = 32
}
tags = {
  Environment = var.environment
}
}
module "alb_frntnd" {
source  = "terraform-aws-modules/alb/aws"
version = "~> 8.0"

name = "${var.environment}-${var.stack_name}-alb-frntnd"

load_balancer_type = "application"

vpc_id             = module.network.vpc_id
subnets            = module.network.public_subnets
security_groups    = [aws_security_group.sg_alb_frntnd.id]

https_listeners = [
  {
    port               = 443
    protocol           = "HTTPS"
    certificate_arn    = var.acm_certificate_arn_alb  # "arn:aws:acm:us-east-1:781862615829:certificate/9a58d937-7dd8-4bb6-bad3-ff378846d56c"
    # certificate_arn    = "arn:aws:acm:us-east-1:781862615829:certificate/9a58d937-7dd8-4bb6-bad3-ff378846d56c"
    target_group_index = 0
  }
]

http_tcp_listeners = [
  {
    port               = 80
    protocol           = "HTTP"
    target_group_index = 0
  }
]
target_groups = [
  {
    name             = "${var.environment}-${var.stack_name}-tg-frntnd"
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "instance"
  },
]

tags = {
  Environment = var.stack_name
}
}

module "alb_bcknd" {
source  = "terraform-aws-modules/alb/aws"
version = "~> 8.0"

name = "${var.environment}-${var.stack_name}-alb-bcknd"

load_balancer_type = "application"

vpc_id             = module.network.vpc_id
subnets            = module.network.private_subnets
security_groups    = [aws_security_group.sg_alb_bcknd.id]

https_listeners = [
  {
    port               = 443
    protocol           = "HTTPS"
    certificate_arn    =  var.acm_certificate_arn_alb  #"arn:aws:acm:us-east-1:xxx:certificate/9a58d937-7dd8-4bb6-bad3-ff378846d56c"
    target_group_index = 0
  }
]

http_tcp_listeners = [
  {
    port               = 80
    protocol           = "HTTP"
    target_group_index = 0
  }
]

target_groups = [
  {
    name             = "${var.environment}-${var.stack_name}-tg-bcknd"
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "instance"
  },
]

tags = {
  Environment = "${var.environment}-${var.stack_name}-alb-bcknd"
}
}

## Terraform script for creating the security group ##
resource "aws_security_group" "rds_sg" {
  vpc_id      = module.network.vpc_id
  name        = "${var.environment}-${var.stack_name}-sg-rds"
  description = "${var.environment}-${var.stack_name} rds security group"
  ingress {
    description = "DB access from backend server"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_bcknd.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "rds_db_subnet_group" {
source  = "terraform-aws-modules/rds/aws//modules/db_subnet_group"
version = "5.9.0"
name         = "${var.environment}-${var.stack_name}-db-subnetgroup"
description  = "${var.environment}-${var.stack_name} db subnetgroup"
subnet_ids = tolist(module.network.database_subnets)

}

module "rds-postgres" {
source  = "terraform-aws-modules/rds-aurora/aws"

name           = "${var.environment}-${var.stack_name}-${var.rds_cluster_identifier}"
engine         = var.engine_type
engine_version = var.engine_version
instance_class = var.db_instance_class
skip_final_snapshot = true
vpc_id = module.network.vpc_id
db_cluster_instance_class = var.db_instance_class
allocated_storage = var.allocated_storage
storage_type = "io1"
iops = 1000
db_subnet_group_name = module.rds_db_subnet_group.db_subnet_group_id
security_group_rules = {
  ex1_ingress_sg = {
    source_security_group_id = aws_security_group.rds_sg.id
  }
}

# Username and password
master_username       = var.db_master_username
master_password       = var.db_master_password
storage_encrypted   = true
apply_immediately   = true
monitoring_interval = 10
enabled_cloudwatch_logs_exports = ["postgresql"]
tags = {
  Environment = "${var.environment}"
  Terraform   = "true"
}
}

# ############## cloudfront_distribution ##############
resource "aws_cloudfront_distribution" "cf" {
comment = "${var.environment}-${var.stack_name}-CF"
price_class = "PriceClass_All"
aliases = ["${var.domain_name}"]
enabled = true
origin {
  domain_name = "${module.alb_frntnd.lb_dns_name}"
  origin_id = "${module.alb_frntnd.lb_arn}"
  custom_origin_config {
    http_port = 80
    https_port = 443
    origin_protocol_policy = "http-only"
    origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
  }
}
default_cache_behavior {
  allowed_methods = ["GET", "HEAD", "OPTIONS"]
  cached_methods = ["GET", "HEAD"]
  target_origin_id = "${module.alb_frntnd.lb_arn}"
  forwarded_values {
    query_string = true
    headers = ["*"]
    cookies {
      forward = "all"
    }
  }
  viewer_protocol_policy = "redirect-to-https"
  min_ttl = 0
  default_ttl = 0
  max_ttl = 0
  
}
restrictions {
  geo_restriction {
    restriction_type = "none"
  }
}

viewer_certificate {
  # acm_certificate_arn = var.acm_certificate_arn  # Replace with your ACM certificate ARN
  acm_certificate_arn = var.acm_certificate_arn_cloudfront
  ssl_support_method  = "sni-only"
}
}

################## Route53 ####################
resource "aws_route53_record" "route53" {
zone_id = var.hosted_zone_id
name    = "${var.domain_name}"
type    = "CNAME"
ttl     = 600 
records = [aws_cloudfront_distribution.cf.domain_name]
}
