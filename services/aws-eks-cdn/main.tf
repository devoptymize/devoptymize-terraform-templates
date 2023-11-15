## Data Block For availability Zone ##
data "aws_availability_zones" "available" {
    state = "available"
}
data "aws_iam_policy" "ssm_managed_instance_core" {
  name = "AmazonSSMManagedInstanceCore"
}


################################## Network ###################################

module "network" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.environment}-${var.stack_name}-vpc"
  cidr = var.vpc_cidr_range


  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets     = var.database_private_subnets

  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true

}



##################################### EKS cluster #######################

module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name                    = "${var.environment}-${var.stack_name}-eks"
  subnet_ids                      = module.network.private_subnets[*]
  vpc_id                          = module.network.vpc_id
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  create_iam_role                 = true


  # EKS Managed Node Group
  eks_managed_node_groups = {
    "${var.environment}-${var.stack_name}_node_group" = {
      min_size       = var.eks_node_group_min_size
      max_size       = var.eks_node_group_max_size
      desired_size   = var.eks_node_group_desired_size
      instance_types = var.eks_node_group_instance_types
      capacity_type  = var.eks_node_group_capacity_type

      create_iam_role          = true
      iam_role_name            = "${var.environment}-${var.stack_name}-node-group"
      iam_role_use_name_prefix = true
      iam_role_description     = "${var.environment}-${var.stack_name}-node-group"

      iam_role_additional_policies = {
        AmazonSSMManagedInstanceCore  = data.aws_iam_policy.ssm_managed_instance_core.arn
      }
    }
  }

 

  # Creating additional security group for cluster
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
    ingress_nodes_ports_tcp = {
      description                = "Allow the pods to communicate with the cluster API Server"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "egress"
      source_node_security_group = true
    }
    egress_all = {
      description      = "Cluster all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  #Creating additional security group for Node-group
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
  }
}


# ############################# RDS cluster ########################################


module "postgres" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "8.3.1"

  name           = "${var.environment}-${var.stack_name}-postgresql"
  engine         = var.engine_type
  engine_version = var.engine_version
  instance_class = var.db_instance_class 
  vpc_id = module.network.vpc_id
  vpc_security_group_ids = [module.rds_security_group.security_group_id]
  db_cluster_instance_class = var.db_instance_class
  create_db_subnet_group = false
  subnets             = module.network.database_subnets[*]
  db_subnet_group_name =  "${var.environment}-${var.stack_name}-subnetgroup"
  allocated_storage = var.rds_storage
  create_security_group = false
  storage_encrypted   = false
  storage_type = "io1"
  iops = "3000"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
  kms_key_id = null
  apply_immediately   = true
  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false

  #Monitoring
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60


  #cluster parameter group
  create_db_cluster_parameter_group = false
  db_cluster_parameter_group_name      = null
  db_cluster_parameter_group_family = null
  db_cluster_parameter_group_parameters = null
  db_cluster_parameter_group_use_name_prefix = false


  #parameter group
  create_db_parameter_group = false
  db_parameter_group_name   = null
  db_parameter_group_parameters = null
  db_parameter_group_family  = null
  db_parameter_group_use_name_prefix = false

  master_username = var.db_master_username
  master_password = var.db_master_password



  
}

# ####################### security group for RDS ############################
module "rds_security_group" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name   = "${var.environment}-${var.stack_name}-rds-sg"
  vpc_id = module.network.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.network.vpc_cidr_block
    }
  ]

  egress_with_cidr_blocks = [
    {
      description      = "PostgreSQL access from outside"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      cidr_blocks      = "0.0.0.0/0"
    }
  ]
}

################################# S3 ####################################


module "s3_bucket" {
  source                  = "terraform-aws-modules/s3-bucket/aws"
  version                 = "3.6.0"
  bucket                  = "${var.environment}-${var.stack_name}-s3-cdn"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  force_destroy = true

  versioning = {
    enabled = true
  }
  tags = {
    purpose = "S3 Bucket for code hosting"
  }
}

# s3 bucket policy
resource "aws_s3_bucket_policy" "s3bucketpolicy" {
  bucket = module.s3_bucket.s3_bucket_id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": {
        "Sid": "AllowCloudFrontServicePrincipalReadOnly",
        "Effect": "Allow",
        "Principal": {
            "Service": "cloudfront.amazonaws.com"
        },
        "Action": "s3:GetObject",
        "Resource": "${module.s3_bucket.s3_bucket_arn}/*",
        "Condition": {
            "StringEquals": {
                "AWS:SourceArn": "${module.cloudfront.cloudfront_distribution_arn}"
            }
        }
    }
}
POLICY
}




######################################### CDN ##########################################


module "cloudfront" {
  source                       = "terraform-aws-modules/cloudfront/aws"
  version                      = "3.2.0"
  
  depends_on = [
    module.s3_bucket,      
  ]
  aliases                      = var.cdn_aliases
  comment                      = "${var.environment}-${var.stack_name}-cdn"
  enabled                      = true
  is_ipv6_enabled              = true
  price_class                  = "PriceClass_All"
  retain_on_delete             = false
  wait_for_deployment          = false
  create_origin_access_control = true
  
  
  origin_access_control = {
    "${var.environment}-${var.stack_name}-cdn" = {
      description      = "${var.environment}-${var.stack_name}-cloudfront-origin"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }
   origin = {
    "${var.environment}-${var.stack_name}-origin" = {
      domain_name           = "${module.s3_bucket.s3_bucket_bucket_regional_domain_name}"
      origin_access_control = "${var.environment}-${var.stack_name}-cdn" # key in `origin_access_control`
      origin_id             = "${var.environment}-${var.stack_name}-${module.s3_bucket.s3_bucket_bucket_regional_domain_name}"
    }
  }
  default_cache_behavior = {
    path_pattern           = "/*"
    target_origin_id       = "${var.environment}-${var.stack_name}-${module.s3_bucket.s3_bucket_bucket_regional_domain_name}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    use_forwarded_values   = false
  }
  viewer_certificate = {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    ssl_support_method  = "sni-only"
  }
  
  default_root_object = "index.html"
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
    purpose = "CF distribution for ${var.environment}-${var.stack_name}-stack"
  }
}



######################################### Route 53 #######################################

resource "aws_route53_record" "record" {
  count = length(var.cdn_aliases)

  zone_id = var.hosted_zone_id
  name    = var.cdn_aliases[count.index]
  type    = "CNAME"
  ttl     = 600 

  records = [module.cloudfront.cloudfront_distribution_domain_name]
}








