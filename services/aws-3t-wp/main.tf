data "aws_availability_zones" "available" {
  state = "available"
}

## Terraform module for creating the network part ##
module "vpc" {
source = "terraform-aws-modules/vpc/aws"
name = "${var.environment}-${var.stack_name}-vpc"
cidr   = var.vpc_cidr_range
azs                   = slice(data.aws_availability_zones.available.names, 0, 2)
public_subnets        = var.public_subnets
private_subnets       = var.app_subnets

# Database Subnets
create_database_subnet_group = true
create_database_subnet_route_table= true
database_subnets     = var.data_subnets

enable_dns_hostnames    = true
enable_nat_gateway      = true
single_nat_gateway      = false  # Set to false to create NAT gateway per AZ
one_nat_gateway_per_az  = true   # Set to true to create NAT gateway per AZ

}


## ALB Security Group ##
resource "aws_security_group" "sg_alb" {
vpc_id      = module.vpc.vpc_id
name        = "${var.environment}-${var.stack_name}-sg-alb"
description = "${var.environment}-${var.stack_name} alb security group"
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

##### Security group private ####
resource "aws_security_group" "sg_app" {
name        = "${var.environment}-${var.stack_name}-sg-app"
description = "${var.environment}-${var.stack_name} security group for app"
vpc_id      = module.vpc.vpc_id

ingress {
  description = "HTTP access"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  security_groups = [aws_security_group.sg_alb.id]
}

ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_alb.id]
  }
ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}
}

### Security group public ###
resource "aws_security_group" "sg_public" {
name        = "${var.environment}-${var.stack_name}-sg-public"
description = "${var.environment}-${var.stack_name} public security group"
vpc_id      = module.vpc.vpc_id
ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}


### Elasticache Security Group ###
resource "aws_security_group" "sg_elasticache" {
name        = "${var.environment}-${var.stack_name}-sg-elasticache"
description = "${var.environment}-${var.stack_name} security group for elasticache"
vpc_id      = module.vpc.vpc_id

ingress {
  description = "Elasticache ingress"
  from_port   = 11211
  to_port     = 11211
  protocol    = "tcp"
  security_groups = [aws_security_group.sg_app.id]
}
egress {
  from_port        = 0
  to_port          = 0
  protocol         = "-1"
  cidr_blocks      = ["0.0.0.0/0"]
}
}

## Private Auto scaling group ##
module "asg_app" { 
source  = "terraform-aws-modules/autoscaling/aws"

# Autoscaling group
name = "${var.environment}-${var.stack_name}-asg-app"

min_size                  = var.asg_min_size
max_size                  = var.asg_max_size
desired_capacity          = var.asg_desired_capacity
wait_for_capacity_timeout = 0
health_check_type         = "ELB"
vpc_zone_identifier       = module.vpc.private_subnets
security_groups           = [aws_security_group.sg_app.id]
# target_group_arns         = module.alb_app.target_group_arns

# Launch template
launch_template_name        = "${var.environment}-${var.stack_name}-lt-app"
launch_template_description = "${var.environment}-${var.stack_name} launch template for app server"
update_default_version      = true

image_id          = var.ami_id
instance_type     = var.instance_type
key_name          = var.key_pair
ebs_optimized     = true
enable_monitoring = true

# IAM role & instance profile
create_iam_instance_profile = true
iam_role_name               = "${var.environment}-${var.stack_name}-asg-app-role"
iam_role_path               = "/ec2/"
iam_role_description        = "${var.environment}-${var.stack_name} asg app iam role "
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
module "asg_public" { 
source  = "terraform-aws-modules/autoscaling/aws"

# Autoscaling group
name = "${var.environment}-${var.stack_name}-asg-public"
# depends_on = [module.alb]

min_size                  = var.asg_min_size
max_size                  = var.asg_max_size
desired_capacity          = var.asg_desired_capacity
wait_for_capacity_timeout = 0
health_check_type         = "EC2"
vpc_zone_identifier       = module.vpc.public_subnets
security_groups           = [aws_security_group.sg_public.id]
# target_group_arns         = module.alb.target_group_arns
## Launch template
launch_template_name        = "${var.environment}-${var.stack_name}-lt-public"
launch_template_description = "${var.environment}-${var.stack_name} launch template for public servers"
update_default_version      = true

image_id          = var.ami_id
instance_type     = var.instance_type
key_name          = var.key_pair
ebs_optimized     = true
enable_monitoring = true
network_interfaces = [
  {
    delete_on_termination = true
    device_index          = 0
    associate_public_ip_address = true
    security_groups       = [aws_security_group.sg_public.id]
  }
]

# IAM role & instance profile
create_iam_instance_profile = true
iam_role_name               = "${var.environment}-${var.stack_name}-asg-public-role"
iam_role_path               = "/ec2/"
iam_role_description        = "${var.environment}-${var.stack_name} asg public iam role"
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

#### ALB ####
module "alb" {
source  = "terraform-aws-modules/alb/aws"
version = "~> 8.0"

name = "${var.environment}-${var.stack_name}-alb-public"

load_balancer_type = "application"

vpc_id             = module.vpc.vpc_id
subnets            = module.vpc.public_subnets
security_groups    = [aws_security_group.sg_alb.id]

https_listeners = [
  {
    port               = 443
    protocol           = "HTTPS"
    certificate_arn    = var.acm_certificate_arn_alb  
    target_group_index = 0
  }
]
target_groups = [
  {
    name             = "${var.environment}-${var.stack_name}-tg-public"
    backend_protocol = "HTTP"
    backend_port     = 80
    target_type      = "instance"
  },
]

tags = {
  Environment = var.environment
}
}

### EFS ###
module "efs" {
  source = "terraform-aws-modules/efs/aws"

  # File system
  name           = "${var.environment}-${var.stack_name}-efs"
  encrypted      = var.encrypted_boolean
  kms_key_arn    = var.kms_key_id

  performance_mode                = var.performance_mode 
  throughput_mode                 = var.throughput_mode
  provisioned_throughput_in_mibps = var.throughput_mode == "bursting" ? null : var.provisioned_throughput_mibps
  mount_targets = {
    "${element(data.aws_availability_zones.available.names, 0)}" = {
      subnet_id = "${element(module.vpc.database_subnets, 0)}"
    }
    "${element(data.aws_availability_zones.available.names, 1)}" = {
      subnet_id = "${element(module.vpc.database_subnets, 1)}"
    }
  }
  security_group_description = "${var.environment}-${var.stack_name} security group for EFS"
  security_group_vpc_id      = module.vpc.vpc_id
  security_group_rules = {
    vpc = {
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }
}

#### Elasticache ####

resource "aws_elasticache_subnet_group" "elasticache" {
  name       = "${var.environment}-${var.stack_name}-elasticache-subnetgroup"
  subnet_ids = tolist(module.vpc.database_subnets)
}

resource "aws_elasticache_cluster" "cache_cluster" {
  cluster_id = "${var.environment}-${var.stack_name}-elasticache-cluster"
  az_mode = "cross-az"
  engine                = "memcached"
  # Note that ElastiCache for Outposts only supports M5 and R5 node families currently
  node_type            = var.elasticache_node_type
  num_cache_nodes      = var.number_of_subnets
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.elasticache.name
  security_group_ids   = [aws_security_group.sg_elasticache.id]
}

## Terraform script for creating the security group ##
resource "aws_security_group" "rds_sg" {
  vpc_id      = module.vpc.vpc_id
  name        = "${var.environment}-${var.stack_name}-sg-rds"
  description = "${var.environment}-${var.stack_name} rds security group"
  ingress {
    description = "${var.environment}-${var.stack_name} ingress"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_security_group.sg_app.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# # #### RDS ####

module "rds_db_subnet_group" {
source  = "terraform-aws-modules/rds/aws//modules/db_subnet_group"
version = "5.9.0"
name         = "${var.environment}-${var.stack_name}-db-subnetgroup"
description  = "${var.environment}-${var.stack_name} db subnetgroup"
subnet_ids = tolist(module.vpc.database_subnets)

}

module "rds_cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  name        = var.rds_cluster_identifier
  engine         = var.engine_type
  engine_version = var.engine_version
  instance_class = var.db_instance_class
  skip_final_snapshot = true
  instances = {
    one = {}
    two = {
      instance_class = var.db_instance_class
    }
  }
  vpc_id = module.vpc.vpc_id
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
  enabled_cloudwatch_logs_exports = var.log_exports == "No" ? [] : var.engine_type == "aurora-postgresql" ? local.aurora_postgresql_log :(contains(regex("^(?:.*(mysql))?.*$",var.engine_type),"mysql") ? local.aurora_mysql_log : (var.engine_type == "postgresql" ? local.postgresql_log : [] ) )
  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}
locals{
  aurora_mysql_log = ["audit", "error", "general", "slowquery"]
  aurora_postgresql_log = ["postgresql"]
  postgresql_log = ["postgresql", "upgrade"]
}

# ############## cloudfront_distribution ##############
resource "aws_cloudfront_distribution" "cloudfront" {
comment = "${var.environment}-${var.stack_name}-cloudfront"
price_class = "PriceClass_All"
aliases = ["${var.domain_name}"]
enabled = true
origin {
  domain_name = "${module.alb.lb_dns_name}"
  origin_id = "${module.alb.lb_arn}"
  custom_origin_config {
    http_port = 80
    https_port = 443
    origin_protocol_policy = "https-only"
    origin_ssl_protocols = ["TLSv1", "TLSv1.1", "TLSv1.2", "SSLv3"]
  }
}
default_cache_behavior {
  allowed_methods = ["GET", "HEAD", "OPTIONS"]
  cached_methods = ["GET", "HEAD"]
  target_origin_id = "${module.alb.lb_arn}"
  compress = true
  cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
  origin_request_policy_id = "216adef6-5c7f-47e4-b989-5492eafa07d3"

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
tags = {
    "Terraform" = "true"
    "Environment" = "${var.environment}"
  }
}

################## Route53 ####################
resource "aws_route53_record" "route53" {
zone_id = var.hosted_zone_id
name    = "${var.domain_name}"
type    = "CNAME"
ttl     = 600 
records = [aws_cloudfront_distribution.cloudfront.domain_name]
}

