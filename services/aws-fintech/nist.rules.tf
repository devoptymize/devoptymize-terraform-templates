resource "aws_config_config_rule" "AccessKeysRotated" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "access-keys-rotated"
  description   = "AWS Config Rule for access keys rotation"
  source {
    owner             = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }
  input_parameters = jsonencode({
    maxAccessKeyAge = "90"
  })
}

resource "aws_config_config_rule" "AcmCertificateExpirationCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "acm-certificate-expiration-check"
  description   = "AWS Config Rule for ACM certificate expiration check"
  source {
    owner             = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }
  input_parameters = jsonencode({
    daysToExpiration = "90"
  })
  scope {
    compliance_resource_types = ["AWS::ACM::Certificate"]
  }
}

resource "aws_config_config_rule" "AlbHttpToHttpsRedirectionCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "alb-http-to-https-redirection-check"
  description   = "AWS Config Rule for ALB HTTP to HTTPS redirection check"
  source {
    owner             = "AWS"
    source_identifier = "ALB_HTTP_TO_HTTPS_REDIRECTION_CHECK"
  }
}

resource "aws_config_config_rule" "ApiGwCacheEnabledAndEncrypted" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "api-gw-cache-enabled-and-encrypted"
  description   = "AWS Config Rule for API Gateway cache enabled and encrypted"
  source {
    owner             = "AWS"
    source_identifier = "API_GW_CACHE_ENABLED_AND_ENCRYPTED"
  }
  scope {
    compliance_resource_types = ["AWS::ApiGateway::Stage"]
  }
}

resource "aws_config_config_rule" "ApiGwExecutionLoggingEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "api-gw-execution-logging-enabled"
  description   = "AWS Config Rule for API Gateway execution logging enabled"
  source {
    owner             = "AWS"
    source_identifier = "API_GW_EXECUTION_LOGGING_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::ApiGateway::Stage", "AWS::ApiGatewayV2::Stage"]
  }
}

resource "aws_config_config_rule" "AutoscalingGroupElbHealthcheckRequired" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "autoscaling-group-elb-healthcheck-required"
  description   = "AWS Config Rule for Autoscaling Group ELB healthcheck required"
  source {
    owner             = "AWS"
    source_identifier = "AUTOSCALING_GROUP_ELB_HEALTHCHECK_REQUIRED"
  }
  scope {
    compliance_resource_types = ["AWS::AutoScaling::AutoScalingGroup"]
  }
}

resource "aws_config_config_rule" "CloudTrailCloudWatchLogsEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloud-trail-cloud-watch-logs-enabled"
  description   = "AWS Config Rule for CloudTrail CloudWatch logs enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_CLOUD_WATCH_LOGS_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrailEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloudtrail-enabled"
  description   = "AWS Config Rule for CloudTrail enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrailEncryptionEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloud-trail-encryption-enabled"
  description   = "AWS Config Rule for CloudTrail encryption enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrailLogFileValidationEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloud-trail-log-file-validation-enabled"
  description   = "AWS Config Rule for CloudTrail log file validation enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudtrailS3DataeventsEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloudtrail-s3-dataevents-enabled"
  description   = "AWS Config Rule for CloudTrail S3 data events enabled"
  source {
    owner             = "AWS"
    source_identifier = "CLOUDTRAIL_S3_DATAEVENTS_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudwatchAlarmActionCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloudwatch-alarm-action-check"
  description   = "AWS Config Rule for CloudWatch alarm action check"
  source {
    owner             = "AWS"
    source_identifier = "CLOUDWATCH_ALARM_ACTION_CHECK"
  }
  input_parameters = jsonencode({
    alarmActionRequired            = "TRUE"
    insufficientDataActionRequired = "TRUE"
    okActionRequired               = "FALSE"
  })
  scope {
    compliance_resource_types = ["AWS::CloudWatch::Alarm"]
  }
}

resource "aws_config_config_rule" "CloudwatchLogGroupEncrypted" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "cloudwatch-log-group-encrypted"
  description   = "AWS Config Rule for CloudWatch log group encryption"
  source {
    owner             = "AWS"
    source_identifier = "CLOUDWATCH_LOG_GROUP_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "CodebuildProjectEnvvarAwscredCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "codebuild-project-envvar-awscred-check"
  description   = "AWS Config Rule for CodeBuild project environment variable AWS credential check"
  source {
    owner             = "AWS"
    source_identifier = "CODEBUILD_PROJECT_ENVVAR_AWSCRED_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::CodeBuild::Project"]
  }
}

resource "aws_config_config_rule" "CodebuildProjectSourceRepoUrlCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "codebuild-project-source-repo-url-check"
  description   = "AWS Config Rule for CodeBuild project source repository URL check"
  source {
    owner             = "AWS"
    source_identifier = "CODEBUILD_PROJECT_SOURCE_REPO_URL_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::CodeBuild::Project"]
  }
}

resource "aws_config_config_rule" "DbInstanceBackupEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "db-instance-backup-enabled"
  description   = "AWS Config Rule for RDS DB instance backup enabled"
  source {
    owner             = "AWS"
    source_identifier = "DB_INSTANCE_BACKUP_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "DmsReplicationNotPublic" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name          = "dms-replication-not-public"
  description   = "AWS Config Rule for DMS replication not being public"
  source {
    owner             = "AWS"
    source_identifier = "DMS_REPLICATION_NOT_PUBLIC"
  }
}


resource "aws_config_config_rule" "EbsOptimizedInstance" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ebs-optimized-instance"
  source {
    owner             = "AWS"
    source_identifier = "EBS_OPTIMIZED_INSTANCE"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }
}

resource "aws_config_config_rule" "EbsSnapshotPublicRestorableCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ebs-snapshot-public-restorable-check"
  source {
    owner             = "AWS"
    source_identifier = "EBS_SNAPSHOT_PUBLIC_RESTORABLE_CHECK"
  }
}

resource "aws_config_config_rule" "Ec2InstanceDetailedMonitoringEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-instance-detailed-monitoring-enabled"
  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_DETAILED_MONITORING_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }
}

resource "aws_config_config_rule" "Ec2InstanceManagedBySsm" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-instance-managed-by-systems-manager"
  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_MANAGED_BY_SSM"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance", "AWS::SSM::ManagedInstanceInventory"]
  }
}

resource "aws_config_config_rule" "Ec2InstanceNoPublicIp" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-instance-no-public-ip"
  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }
}

resource "aws_config_config_rule" "Ec2ManagedinstanceAssociationComplianceStatusCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-managedinstance-association-compliance-status-check"
  source {
    owner             = "AWS"
    source_identifier = "EC2_MANAGEDINSTANCE_ASSOCIATION_COMPLIANCE_STATUS_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::SSM::AssociationCompliance"]
  }
}

resource "aws_config_config_rule" "Ec2ManagedinstancePatchComplianceStatusCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-managedinstance-patch-compliance-status-check"
  source {
    owner             = "AWS"
    source_identifier = "EC2_MANAGEDINSTANCE_PATCH_COMPLIANCE_STATUS_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::SSM::PatchCompliance"]
  }
}

resource "aws_config_config_rule" "Ec2SecurityGroupAttachedToEni" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-security-group-attached-to-eni"
  source {
    owner             = "AWS"
    source_identifier = "EC2_SECURITY_GROUP_ATTACHED_TO_ENI"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}

resource "aws_config_config_rule" "Ec2StoppedInstance" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-stopped-instance"
  source {
    owner             = "AWS"
    source_identifier = "EC2_STOPPED_INSTANCE"
  }
}

resource "aws_config_config_rule" "Ec2VolumeInuseCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-volume-inuse-check"
  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Volume"]
  }
}

resource "aws_config_config_rule" "EfsEncryptedCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "efs-encrypted-check"
  source {
    owner             = "AWS"
    source_identifier = "EFS_ENCRYPTED_CHECK"
  }
}

resource "aws_config_config_rule" "EipAttached" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "eip-attached"
  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::EIP"]
  }
}

resource "aws_config_config_rule" "ElasticacheRedisClusterAutomaticBackupCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "elasticache-redis-cluster-automatic-backup-check"
  source {
    owner             = "AWS"
    source_identifier = "ELASTICACHE_REDIS_CLUSTER_AUTOMATIC_BACKUP_CHECK"
  }
}

resource "aws_config_config_rule" "ElasticsearchEncryptedAtRest" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "elasticsearch-encrypted-at-rest"
  source {
    owner             = "AWS"
    source_identifier = "ELASTICSEARCH_ENCRYPTED_AT_REST"
  }
}

resource "aws_config_config_rule" "ElasticsearchInVpcOnly" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "elasticsearch-in-vpc-only"
  source {
    owner             = "AWS"
    source_identifier = "ELASTICSEARCH_IN_VPC_ONLY"
  }
}

resource "aws_config_config_rule" "ElbAcmCertificateRequired" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "elb-acm-certificate-required"
  source {
    owner             = "AWS"
    source_identifier = "ELB_ACM_CERTIFICATE_REQUIRED"
  }
  scope {
    compliance_resource_types = ["AWS::ElasticLoadBalancing::LoadBalancer"]
  }
}

resource "aws_config_config_rule" "ElbDeletionProtectionEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "elb-deletion-protection-enabled"
  source {
    owner             = "AWS"
    source_identifier = "ELB_DELETION_PROTECTION_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::ElasticLoadBalancingV2::LoadBalancer"]
  }
}

resource "aws_config_config_rule" "ElbLoggingEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "elb-logging-enabled"
  source {
    owner             = "AWS"
    source_identifier = "ELB_LOGGING_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::ElasticLoadBalancing::LoadBalancer", "AWS::ElasticLoadBalancingV2::LoadBalancer"]
  }
}

resource "aws_config_config_rule" "EmrKerberosEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "emr-kerberos-enabled"
  source {
    owner             = "AWS"
    source_identifier = "EMR_KERBEROS_ENABLED"
  }
}

resource "aws_config_config_rule" "EmrMasterNoPublicIp" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "emr-master-no-public-ip"
  source {
    owner             = "AWS"
    source_identifier = "EMR_MASTER_NO_PUBLIC_IP"
  }
}

resource "aws_config_config_rule" "EncryptedVolumes" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "encrypted-volumes"
  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Volume"]
  }
}

resource "aws_config_config_rule" "GuarddutyEnabledCentralized" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "guardduty-enabled-centralized"
  source {
    owner             = "AWS"
    source_identifier = "GUARDDUTY_ENABLED_CENTRALIZED"
  }
}

resource "aws_config_config_rule" "GuarddutyNonArchivedFindings" {
  count = strcontains(var.aws_configrules, "nist") ? 1 : 0
  name = "guardduty-non-archived-findings"
  source {
    owner             = "AWS"
    source_identifier = "GUARDDUTY_NON_ARCHIVED_FINDINGS"
  }
  input_parameters = jsonencode({
    "daysHighSev": "1",
    "daysLowSev": "30",
    "daysMediumSev": "7"
  })
}


resource "aws_config_config_rule" "IamGroupHasUsersCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "iam-group-has-users-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_GROUP_HAS_USERS_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::IAM::Group"]
  }
}

resource "aws_config_config_rule" "IamPasswordPolicy" {
  count = strcontains(var.aws_configrules, "nist") ? 1 : 0
  name = "iam-password-policy"
  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
  input_parameters = jsonencode({
    "MaxPasswordAge": "90",
    "MinimumPasswordLength": "14",
    "PasswordReusePrevention": "24",
    "RequireLowercaseCharacters": "true",
    "RequireNumbers": "true",
    "RequireSymbols": "true",
    "RequireUppercaseCharacters": "true"
  })
}


resource "aws_config_config_rule" "IamPolicyNoStatementsWithAdminAccess" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "iam-policy-no-statements-with-admin-access"
  source {
    owner             = "AWS"
    source_identifier = "IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS"
  }
  scope {
    compliance_resource_types = ["AWS::IAM::Policy"]
  }
}

resource "aws_config_config_rule" "IamRootAccessKeyCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "iam-root-access-key-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }
}

resource "aws_config_config_rule" "IamUserGroupMembershipCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "iam-user-group-membership-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_GROUP_MEMBERSHIP_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::IAM::User"]
  }
}

resource "aws_config_config_rule" "IamUserMfaEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "iam-user-mfa-enabled"
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "IamUserNoPoliciesCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "iam-user-no-policies-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::IAM::User"]
  }
}

resource "aws_config_config_rule" "IamUserUnusedCredentialsCheck" {
  count = strcontains(var.aws_configrules, "nist") ? 1 : 0
  name = "iam-user-unused-credentials-check"
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }
  input_parameters = jsonencode({
    "maxCredentialUsageAge": "90"
  })
}


resource "aws_config_config_rule" "IncomingSshDisabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "restricted-ssh"
  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}

resource "aws_config_config_rule" "InstancesInVpc" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "ec2-instances-in-vpc"
  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }
}

resource "aws_config_config_rule" "InternetGatewayAuthorizedVpcOnly" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "internet-gateway-authorized-vpc-only"
  source {
    owner             = "AWS"
    source_identifier = "INTERNET_GATEWAY_AUTHORIZED_VPC_ONLY"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::InternetGateway"]
  }
}

resource "aws_config_config_rule" "KmsCmkNotScheduledForDeletion" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "kms-cmk-not-scheduled-for-deletion"
  source {
    owner             = "AWS"
    source_identifier = "KMS_CMK_NOT_SCHEDULED_FOR_DELETION"
  }
  scope {
    compliance_resource_types = ["AWS::KMS::Key"]
  }
}

resource "aws_config_config_rule" "LambdaConcurrencyCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "lambda-concurrency-check"
  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_CONCURRENCY_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::Lambda::Function"]
  }
}

resource "aws_config_config_rule" "LambdaDlqCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "lambda-dlq-check"
  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_DLQ_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::Lambda::Function"]
  }
}

resource "aws_config_config_rule" "LambdaFunction-PublicAccessProhibited" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "lambda-function-public-access-prohibited"
  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED"
  }
  scope {
    compliance_resource_types = ["AWS::Lambda::Function"]
  }
}

resource "aws_config_config_rule" "Lambda-InsideVpc" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "lambda-inside-vpc"
  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_INSIDE_VPC"
  }
  scope {
    compliance_resource_types = ["AWS::Lambda::Function"]
  }
}

resource "aws_config_config_rule" "Mfa-EnabledForIamConsoleAccess" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "mfa-enabled-for-iam-console-access"
  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }
}

resource "aws_config_config_rule" "MultiRegion-CloudTrailEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "multi-region-cloudtrail-enabled"
  source {
    owner             = "AWS"
    source_identifier = "MULTI_REGION_CLOUD_TRAIL_ENABLED"
  }
}

resource "aws_config_config_rule" "RdsEnhanced-MonitoringEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "rds-enhanced-monitoring-enabled"
  source {
    owner             = "AWS"
    source_identifier = "RDS_ENHANCED_MONITORING_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "RdsInstance-PublicAccessCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "rds-instance-public-access-check"
  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "Rds-MultiAzSupport" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "rds-multi-az-support"
  source {
    owner             = "AWS"
    source_identifier = "RDS_MULTI_AZ_SUPPORT"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "RdsSnapshots-PublicProhibited" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "rds-snapshots-public-prohibited"
  source {
    owner             = "AWS"
    source_identifier = "RDS_SNAPSHOTS_PUBLIC_PROHIBITED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBSnapshot", "AWS::RDS::DBClusterSnapshot"]
  }
}

resource "aws_config_config_rule" "RdsStorage-Encrypted" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "rds-storage-encrypted"
  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "RedshiftCluster-ConfigurationCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "redshift-cluster-configuration-check"
  source {
    owner             = "AWS"
    source_identifier = "REDSHIFT_CLUSTER_CONFIGURATION_CHECK"
  }
  input_parameters = "{\"clusterDbEncrypted\": \"TRUE\", \"loggingEnabled\": \"TRUE\"}"
  scope {
    compliance_resource_types = ["AWS::Redshift::Cluster"]
  }
}

resource "aws_config_config_rule" "RedshiftCluster-PublicAccessCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "redshift-cluster-public-access-check"
  source {
    owner             = "AWS"
    source_identifier = "REDSHIFT_CLUSTER_PUBLIC_ACCESS_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::Redshift::Cluster"]
  }
}

resource "aws_config_config_rule" "Redshift-RequireTlsSsl" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "redshift-require-tls-ssl"
  source {
    owner             = "AWS"
    source_identifier = "REDSHIFT_REQUIRE_TLS_SSL"
  }
  scope {
    compliance_resource_types = ["AWS::Redshift::Cluster"]
  }
}

resource "aws_config_config_rule" "Restricted-IncomingTraffic" {
  count = strcontains(var.aws_configrules, "nist") ? 1 : 0
  name = "restricted-common-ports"
  input_parameters = jsonencode({
    "blockedPort1": "20",
    "blockedPort2": "21",
    "blockedPort3": "3389",
    "blockedPort4": "3306",
    "blockedPort5": "4333"
  })
  source {
    owner             = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}



resource "aws_config_config_rule" "RootAccount-HardwareMfaEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "root-account-hardware-mfa-enabled"
  source {
    owner            = "AWS"
    source_identifier = "ROOT_ACCOUNT_HARDWARE_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "RootAccount-MfaEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "root-account-mfa-enabled"
  source {
    owner            = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "S3AccountLevel-PublicAccessBlocks" {
  count = strcontains(var.aws_configrules, "nist") ? 1 : 0
  name = "s3-account-level-public-access-blocks"

  input_parameters = jsonencode({
    "BlockPublicAcls": "true",
    "BlockPublicPolicy": "true",
    "IgnorePublicAcls": "true",
    "RestrictPublicBuckets": "true"
  })

  scope {
    compliance_resource_types = ["AWS::S3::AccountPublicAccessBlock"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_ACCOUNT_LEVEL_PUBLIC_ACCESS_BLOCKS"
  }
}

resource "aws_config_config_rule" "S3Bucket-DefaultLockEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-default-lock-enabled"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_DEFAULT_LOCK_ENABLED"
  }
}

resource "aws_config_config_rule" "S3Bucket-LoggingEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-logging-enabled"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "S3BucketPolicy-GranteeCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-policy-grantee-check"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_POLICY_GRANTEE_CHECK"
  }
}

resource "aws_config_config_rule" "S3Bucket-PublicReadP-rohibited" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-public-read-prohibited"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}

resource "aws_config_config_rule" "S3Bucket--PublicWriteProhibited" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-public-write-prohibited"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
}

resource "aws_config_config_rule" "S3Bucket-ReplicationEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-replication-enabled"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_REPLICATION_ENABLED"
  }
}

resource "aws_config_config_rule" "S3Bucket-ServerSideEncryptionEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-server-side-encryption-enabled"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "S3Bucket-SslRequestsOnly" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-ssl-requests-only"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }
}

resource "aws_config_config_rule" "S3Bucket-VersioningEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "s3-bucket-versioning-enabled"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }
}

resource "aws_config_config_rule" "Sagemaker-EndpointConfigurationKmsKeyConfigured" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "sagemaker-endpoint-configuration-kms-key-configured"

  source {
    owner            = "AWS"
    source_identifier = "SAGEMAKER_ENDPOINT_CONFIGURATION_KMS_KEY_CONFIGURED"
  }
}

resource "aws_config_config_rule" "Sagemaker-NotebookInstanceKmsKeyConfigured" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "sagemaker-notebook-instance-kms-key-configured"

  source {
    owner            = "AWS"
    source_identifier = "SAGEMAKER_NOTEBOOK_INSTANCE_KMS_KEY_CONFIGURED"
  }
}

resource "aws_config_config_rule" "Sagemaker-NotebookNoDirectInternetAccess" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "sagemaker-notebook-no-direct-internet-access"

  source {
    owner            = "AWS"
    source_identifier = "SAGEMAKER_NOTEBOOK_NO_DIRECT_INTERNET_ACCESS"
  }
}

resource "aws_config_config_rule" "Secretsmanager-RotationEnabledCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "secretsmanager-rotation-enabled-check"

  scope {
    compliance_resource_types = ["AWS::SecretsManager::Secret"]
  }

  source {
    owner            = "AWS"
    source_identifier = "SECRETSMANAGER_ROTATION_ENABLED_CHECK"
  }
}

resource "aws_config_config_rule" "Secretsmanager-ScheduledRotationSuccessCheck" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "secretsmanager-scheduled-rotation-success-check"

  scope {
    compliance_resource_types = ["AWS::SecretsManager::Secret"]
  }

  source {
    owner            = "AWS"
    source_identifier = "SECRETSMANAGER_SCHEDULED_ROTATION_SUCCESS_CHECK"
  }
}

resource "aws_config_config_rule" "Security-hubEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "securityhub-enabled"

  source {
    owner            = "AWS"
    source_identifier = "SECURITYHUB_ENABLED"
  }
}

resource "aws_config_config_rule" "SnsEncryptedKms" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "sns-encrypted-kms"

  scope {
    compliance_resource_types = ["AWS::SNS::Topic"]
  }

  source {
    owner            = "AWS"
    source_identifier = "SNS_ENCRYPTED_KMS"
  }
}

resource "aws_config_config_rule" "VpcDefault-SecurityGroupClosed" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "vpc-default-security-group-closed"

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"
  }
}

resource "aws_config_config_rule" "Vpc-FlowLogsEnabled" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "vpc-flow-logs-enabled"

  source {
    owner            = "AWS"
    source_identifier = "VPC_FLOW_LOGS_ENABLED"
  }
}

resource "aws_config_config_rule" "VpcSg-OpenOnlyToAuthorizedPorts" {
  count = strcontains(var.aws_configrules,"nist")? 1:0  
  name = "vpc-sg-open-only-to-authorized-ports"

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "VPC_SG_OPEN_ONLY_TO_AUTHORIZED_PORTS"
  }
}

resource "aws_config_config_rule" "VpcVpn2-TunnelsUp" {
  count = strcontains(var.aws_configrules,"nist")? 1:0
  name = "vpc-vpn-2-tunnels-up"

  scope {
    compliance_resource_types = ["AWS::EC2::VPNConnection"]
  }

  source {
    owner            = "AWS"
    source_identifier = "VPC_VPN_2_TUNNELS_UP"
  }
}
