module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = var.rds_cluster_identifier
  engine         = var.engine_type
  engine_version = var.engine_version
  instance_class = var.db_instance_class
  instances = var.engine_type == "mysql" || var.engine_type == "postgres" ? {} : {
      one   = var.db_instance_one == "default" ? {
        instance_class = var.db_instance_class
      } : var.db_instance_one_custom
      two   = var.db_instance_two == "default" ? {
        instance_class = var.db_instance_class
      } : var.db_instance_two_custom
      three = var.db_instance_three == "default" ? {
        instance_class = var.db_instance_class
      } : var.db_instance_three_custom
  }

  db_cluster_instance_class = var.engine_type == "aurora-mysql" || var.engine_type == "aurora-postgresql" ? null : var.db_instance_class
  vpc_id = var.vpc_id
  create_db_subnet_group = var.subnet_group == "null" ? true : false
  subnets             = var.subnet_group == "null" ? var.subnet_id : []
  vpc_security_group_ids = var.security_group_id
  

  db_subnet_group_name = var.subnet_group == "null" ? null : var.subnet_group
 
  create_security_group = false

  allocated_storage = var.engine_type == "aurora-mysql" || var.engine_type == "aurora-postgresql" ? null : var.rds_storage
  storage_encrypted   = var.encryption == "null" ? false : true
  storage_type = var.engine_type == "aurora-mysql" || var.engine_type == "aurora-postgresql" ? null : var.storage_type
  iops = var.engine_type == "aurora-mysql" || var.engine_type == "aurora-postgresql" ? null :  var.iops
  publicly_accessible = var.public_access == "Yes" ? true : false
  kms_key_id = var.encryption == "null" ? null : var.encryption 
  apply_immediately   = true
  backup_retention_period = 7
  deletion_protection     = false
  skip_final_snapshot = true

  #Monitoring
  create_monitoring_role                = true
  monitoring_interval                   = 60


  #cluster parameter group
  create_db_cluster_parameter_group = var.cluster_parameter_group == "null" ? true : false
  db_cluster_parameter_group_name      = var.cluster_parameter_group == "null" || var.cluster_parameter_group == "default" ? null : var.cluster_parameter_group
  db_cluster_parameter_group_family = var.cluster_parameter_group == "null" ? var.dbparameter_family : null
  db_cluster_parameter_group_parameters = var.cluster_parameter_group == "null" ? local.clpgrp : null
  db_cluster_parameter_group_use_name_prefix = false


  #parameter group
  create_db_parameter_group = var.parameter_group == "null" ? true : false
  db_parameter_group_name   = var.parameter_group == "null" || var.parameter_group == "default" ? null : var.parameter_group
  db_parameter_group_parameters = var.parameter_group == "null" ? local.pgrp : null
  db_parameter_group_family  = var.parameter_group == "null" ? var.dbparameter_family : null
  db_parameter_group_use_name_prefix = false

  
  #username and password
  master_username = var.db_master_username
  master_password = var.db_master_password

  #logs
  enabled_cloudwatch_logs_exports = var.log_exports == "No" ? [] : var.engine_type == "aurora-postgresql" ? local.aurora_postgresql_log :(contains(regex("^(?:.*(mysql))?.*$",var.engine_type),"mysql") ? local.aurora_mysql_log : (var.engine_type == "postgresql" ? local.postgresql_log : [] ) )
}

locals{
  aurora_mysql_log = ["audit", "error", "general", "slowquery"]
  aurora_postgresql_log = ["postgresql"]
  postgresql_log = ["postgresql", "upgrade"]
  pgrp = var.parameter_group_new == "" ? null : [ for v in var.parameter_group_new : {  name = v[0], value = v[1]  } ]
  clpgrp = var.cluster_parameter_group_new == "" ? null : [ for v in var.cluster_parameter_group_new : {  name = v[0], value = v[1]  } ] 
}
