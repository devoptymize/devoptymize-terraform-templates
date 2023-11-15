data "aws_availability_zones" "available" {
    state = "available"
}

## Terraform module for creating the network part ##
module "network" {
  source = "terraform-aws-modules/vpc/aws"
  name = "${var.environment}-${var.stack_name}-vpc"
  cidr   = var.vpc_cidr_range

  public_subnets        = var.public_subnets
  private_subnets       = var.private_subnets
  azs             = slice(data.aws_availability_zones.available.names, 0, 2)

  enable_dns_hostnames    = true
  enable_nat_gateway      = true
  single_nat_gateway      = false  # Set to false to create NAT gateway per AZ
  one_nat_gateway_per_az  = true   # Set to true to create NAT gateway per AZ

}

####### security group for bastion host ######
resource "aws_security_group" "sg" {
  vpc_id      = module.network.vpc_id
  name        = "${var.environment}-${var.stack_name}-sg"
  description = "${var.environment}-${var.stack_name} security group"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



## Terraform script for creating the asg for bastion web server ##
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = "${var.environment}-${var.stack_name}-asg"

  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"
  vpc_zone_identifier       = module.network.public_subnets
  security_groups           = [aws_security_group.sg.id]

  # Launch template
  launch_template_name        = "${var.environment}-${var.stack_name}-lt"
  launch_template_description = "${var.environment}-${var.stack_name} launch template"
  update_default_version      = true

  image_id          = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_pair
  ebs_optimized     = true
  enable_monitoring = true

   # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "${var.environment}-${var.stack_name}-asg-role"
  iam_role_path               = "/ec2/"
  iam_role_description        = "IAM role for asg"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  } 

  block_device_mappings = [
    {
      # Root volume
      device_name = "/dev/sdb"
      no_device   = 0
      ebs = {
        delete_on_termination = true
        encrypted             = true
        volume_size           = var.volume_size
        volume_type           = var.volume_type
      }
    },
  ]
  capacity_reservation_specification = {
    capacity_reservation_preference = "open"
  }

  disable_api_stop        = true
  disable_api_termination = true

  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 32
  }

  network_interfaces = [
    {
      associate_public_ip_address = false
      delete_on_termination = true
      description           = "${var.environment}-${var.stack_name} network_interfaces"
      device_index          = 0
      security_groups       = [aws_security_group.sg.id]
    }

  ]
 
  tags = {
    Environment = var.environment
    Project     = "${var.environment}-${var.stack_name}-asg"
  }
}

######## Security group for rds #####
resource "aws_security_group" "rds_sg" {
  vpc_id      = module.network.vpc_id
  name        = "${var.environment}-${var.stack_name}-sg-rds"
  description = "${var.environment}-${var.stack_name} rds security group"
  ingress     = local.ingress_rules

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_range]
  }
}

locals {
  engine_type = var.engine_type

  mysql_ingress = {
    from_port         = 3306
    to_port           = 3306
    protocol          = "tcp"
    cidr_blocks       = [var.vpc_cidr_range]
    security_groups   = []
    description       = "MySQL Ingress"
    ipv6_cidr_blocks  = []
    prefix_list_ids  = []
    self              = false
  }

  postgres_ingress = {
    from_port         = 5432
    to_port           = 5432
    protocol          = "tcp"
    cidr_blocks       = [var.vpc_cidr_range]
    security_groups   = []
    description       = "PostgreSQL Ingress"
    ipv6_cidr_blocks  = []
    prefix_list_ids  = []
    self              = false
  }

  selected_ingress = {
    mysql     = [local.mysql_ingress]
    postgres  = [local.postgres_ingress]
  }

  ingress_rules = concat(
    try(local.selected_ingress[local.engine_type], []),
    [
      # Additional global ingress rules can be added here
    ]
  )
}

######  DB subnet group #######

module "rds_db_subnet_group" {
  source  = "terraform-aws-modules/rds/aws//modules/db_subnet_group"
  version = "5.9.0"
  name         = "${var.environment}-${var.stack_name}-db-subnetgroup"
  description  = "${var.environment}-${var.stack_name} db subnetgroup"
  subnet_ids = tolist(module.network.private_subnets)

}

############ Db instances with replicas in different azs ###########

resource "aws_db_instance" "master" {
  allocated_storage    = var.rds_storage
  storage_type         = var.storage_type
  engine               = var.engine_type
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  identifier           = "${var.environment}-${var.stack_name}-${var.rds_identifier}-rds"
  username             = var.db_master_username
  password             = var.db_master_password
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  # Enable automated backups
  backup_retention_period = 7 
  backup_window               = "03:00-06:00"
  maintenance_window          = "Mon:00:00-Mon:03:00"
  multi_az             = true
  db_subnet_group_name = module.rds_db_subnet_group.db_subnet_group_id
  kms_key_id = module.kms.key_arn
  storage_encrypted   = true
  apply_immediately   = true

  performance_insights_enabled          = true
  performance_insights_retention_period = 7

  // CloudWatch Logs export configuration
  enabled_cloudwatch_logs_exports = local.enabled_cloudwatch_logs_exports

  tags = {
    Name = "${var.environment}-${var.stack_name}-rds-master"
  }
}

resource "aws_db_instance" "replica" {

  depends_on = [aws_db_instance.master]

  count                = 2
  storage_type         = var.storage_type
  engine               = var.engine_type
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class
  identifier           = "${var.environment}-${var.stack_name}-${var.rds_identifier}-replica-${count.index}"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  replicate_source_db = aws_db_instance.master.identifier  # Reference the master instance
    // CloudWatch Logs export configuration
  enabled_cloudwatch_logs_exports = local.enabled_cloudwatch_logs_exports
  # Enable automated backups for replicas
  backup_retention_period = 7 
  backup_window               = "03:00-06:00"
  maintenance_window          = "Mon:00:00-Mon:03:00"
  multi_az                    = true
  storage_encrypted = true
  kms_key_id = module.kms.key_arn
  tags = {
    Name = "${var.environment}-${var.stack_name}-replica-${count.index}"
  }
}


locals {
  mysql_mariadb_log = ["audit", "error", "general", "slowquery"]
  postgresql_log   = ["postgresql", "upgrade"]

  enabled_cloudwatch_logs_exports = var.log_exports == "No" ?[] :var.engine_type == "postgres" ? local.postgresql_log :var.engine_type == "mysql" ? local.mysql_mariadb_log :[]
}


############# cloudwatch metric #############
resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "HighCPUAlarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "1"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/RDS"
  period             = "300"
  statistic          = "Average"
  threshold          = "80"
  alarm_description = "This metric checks for high CPU utilization on the RDS instance"
  alarm_actions     = [aws_sns_topic.db_notifications.arn]
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.master.identifier
  }
}

######## SNS notification ##############
resource "aws_sns_topic" "db_notifications" {
  name = "${var.environment}-${var.stack_name}-DBNotifications"
  display_name = "${var.environment}-${var.stack_name} DB Notifications"
}

resource "aws_sns_topic_policy" "db_notifications_policy" {
  arn = aws_sns_topic.db_notifications.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "SnsTopicPolicy",
    Statement = [
      {
        Sid       = "AllowCloudWatchAlarms",
        Effect    = "Allow",
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        },
        Action    = "SNS:Publish",
        Resource  = aws_sns_topic.db_notifications.arn
      },
      {
        Sid       = "AllowRDSEventNotifications",
        Effect    = "Allow",
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Action    = "SNS:Publish",
        Resource  = aws_sns_topic.db_notifications.arn
      }
    ]
  })
}

# Define SNS topic subscription for CloudWatch alarms
resource "aws_sns_topic_subscription" "cloudwatch_subscription" {
  for_each = { for email in var.email_address : email => email }
  topic_arn = aws_sns_topic.db_notifications.arn
  protocol  = "email"  # Change this to the desired protocol (email, sms, etc.)
  endpoint  = each.value 
}

# Create RDS Event Subscription for sending RDS event notifications to the SNS topic
resource "aws_db_event_subscription" "db_event_subscription" {
  name           = "${var.environment}-${var.stack_name}-DBEventSubscription"
  sns_topic      = "${aws_sns_topic.db_notifications.arn}"  
  source_type    = "db-instance"
  event_categories = [
    "availability",
    "deletion",
    "failover",
    "failure",
    "low storage",
    "maintenance",
    "notification",
    "read replica",
    "recovery",
    "restoration",
  ]
}

resource "aws_cloudwatch_log_group" "db_logs" {
  name = "/aws/rds/instance/${aws_db_instance.master.identifier}/loggroup"
  retention_in_days = 7
}

################ KMS Key ######################
module "kms" {
  source = "terraform-aws-modules/kms/aws"
  version = "1.5.0"
  description = "RDS database encryption key"
  key_usage   = "ENCRYPT_DECRYPT"

  # Policy
  enable_default_policy                  = true

  # Aliases
  aliases = ["aws-rds-stack/rds"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Name = "${var.environment}-${var.stack_name}-kms"
  }
}
