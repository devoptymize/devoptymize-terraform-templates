module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.rds_name

  engine               = var.engine_type
  engine_version       = var.engine_version
  instance_class       = var.db_instance_class

  allocated_storage     = var.rds_storage == "" ? null : var.rds_storage
  max_allocated_storage = 1000

  # Encryption at rest is not available for DB instances running SQL Server Express Edition
  storage_encrypted = var.encryption == "null" ? false : true
  kms_key_id = var.encryption == "null" ? null : var.encryption

  username = var.db_master_username  
   password = var.db_master_password

  multi_az               = var.multi_az_deployment == "yes" ? true : false
  # subnets or subnet group
  # Enable creation of subnet group (disabled by default)
  create_db_subnet_group = var.subnet_group == "null" ? true : false
  subnet_ids             = var.subnet_group == "null" ? var.subnet_id : []
  db_subnet_group_name = var.subnet_group == "null" ? null : var.subnet_group

  vpc_security_group_ids = var.security_group_id
  publicly_accessible    = var.public_access == "yes" ? true : false

  backup_retention_period = 7
  skip_final_snapshot     = false
  deletion_protection     = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "${var.rds_name}-monitoring-role"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "${var.rds_name} monitoring role"
  
  #parameter group
  create_db_parameter_group = var.parameter_group == "null" ? true : false
  parameter_group_name   = var.parameter_group == "null" || var.parameter_group == "default" ? null : var.parameter_group
  parameters = var.parameter_group == "null" ? local.pgrp : null
  family  = var.parameter_group == "null" ? var.dbparameter_family : null
   parameter_group_use_name_prefix = false
  # Option group
  create_db_option_group = var.option_group == "null" ? true : false
  option_group_name      = var.option_group == "null" || var.option_group == "default"  ? null : var.option_group
  options = var.option_group == "null" ? var.option_group_new : null
  major_engine_version = var.option_group == "null" ? format("%.3s", var.engine_version ) : null
  option_group_use_name_prefix = false


  enabled_cloudwatch_logs_exports = var.log_exports == "No" ? [] : contains(regex("^(?:.*(postgres))?.*$",var.engine_type),"postgres") ? local.postgresql_log :(contains(regex("^(?:.*(mysql))?.*$",var.engine_type),"mysql") ? local.mysql_mariadb_log :(contains(regex("^(?:.*(sqlserver))?.*$",var.engine_type),"sqlserver") ? local.mssql_log :(contains(regex("^(?:.*(oracle))?.*$",var.engine_type),"oracle") ? local.oracle_log :(var.engine_type == "mariadb") ? local.mysql_mariadb_log : [] )))

  // Conditionally specify license model for Oracle
  license_model = var.engine_type == "oracle" || var.engine_type == "oracle-se2" ? "license-included" : null

}

locals{
  mysql_mariadb_log = ["audit", "error", "general", "slowquery"]
  postgresql_log = ["postgresql", "upgrade"]
  mssql_log =["agent" , "error"]
  oracle_log = ["alert", "audit", "listener", "trace"]

  pgrp = var.parameter_group_new == "" ? null : [ for v in var.parameter_group_new : {  name = v[0], value = v[1]  } ]
  
}
