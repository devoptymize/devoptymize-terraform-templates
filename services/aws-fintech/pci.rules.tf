resource "aws_config_config_rule" "AccessKey-sRotated" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "accesskeys-rotated"

  description = "Checks whether the active access keys are rotated within the number of days specified in maxAccessKeyAge. The rule is non-compliant if the access keys have not been rotated for more than maxAccessKeyAge number of days."

  input_parameters = jsonencode({
    maxAccessKeyAge = "90"
  })

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }
}

resource "aws_config_config_rule" "AcmCertificate-ExpirationCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "acm-certificate-expirationcheck"

  description = "Checks whether ACM Certificates in your account are marked for expiration within the specified number of days. Certificates provided by ACM are automatically renewed. ACM does not automatically renew certificates that you import."

  input_parameters = jsonencode({
    daysToExpiration = "90"
  })

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = ["AWS::ACM::Certificate"]
  }

  source {
    owner            = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }
}

resource "aws_config_config_rule" "AlbHttpToHttps-RedirectionCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "alb-http-to-https-redirectioncheck"

  description = "Checks whether HTTP to HTTPS redirection is configured on all HTTP listeners of Application Load Balancers. The rule is NON_COMPLIANT if one or more HTTP listeners of Application Load Balancer do not have HTTP to HTTPS redirection configured."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "ALB_HTTP_TO_HTTPS_REDIRECTION_CHECK"
  }
}

resource "aws_config_config_rule" "ApiGwCache-EnabledAndEncrypted" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "api-gw-cacheenabled-and-encrypted"

  description = "Checks that all methods in Amazon API Gateway stages have cache enabled and cache encrypted. The rule is NON_COMPLIANT if any method in Amazon API Gateway stage is not configured to cache or the cache is not encrypted."

  scope {
    compliance_resource_types = ["AWS::ApiGateway::Stage"]
  }

  source {
    owner            = "AWS"
    source_identifier = "API_GW_CACHE_ENABLED_AND_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "ApiGwExecution-LoggingEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "api-gw-executionlogging-enabled"

  description = "Checks that all methods in Amazon API Gateway stage has logging enabled. The rule is NON_COMPLIANT if logging is not enabled. The rule is NON_COMPLIANT if loggingLevel is neither ERROR nor INFO."

  scope {
    compliance_resource_types = ["AWS::ApiGateway::Stage", "AWS::ApiGatewayV2::Stage"]
  }

  source {
    owner            = "AWS"
    source_identifier = "API_GW_EXECUTION_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrail-CloudWatchLogsEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cloud-trail-cloudwatch-logs-enabled"

  description = "Checks whether AWS CloudTrail trails are configured to send logs to Amazon CloudWatch logs. The trail is non-compliant if the CloudWatchLogsLogGroupArn property of the trail is empty."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CLOUD_TRAIL_CLOUD_WATCH_LOGS_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrail-Enabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cloudtrailenabled"

  description = "Checks whether AWS CloudTrail is enabled in your AWS account."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrail-EncryptionEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cloudtrail-encryption-enabled"

  description = "Checks whether AWS CloudTrail is configured to use the server side encryption (SSE) AWS Key Management Service (AWS KMS) customer master key (CMK) encryption. The rule is compliant if the KmsKeyId is defined."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CLOUD_TRAIL_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudTrailLog-FileValidationEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cloudtrail-log-file-validation-enabled"

  description = "Checks whether AWS CloudTrail creates a signed digest file with logs. AWS recommends that the file validation must be enabled on all trails. The rule is noncompliant if the validation is not enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudtrailS3-DataeventsEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cloudtrail-s3-dataeventsenabled"

  description = "Checks whether at least one AWS CloudTrail trail is logging Amazon S3 data events for all S3 buckets. The rule is NON_COMPLIANT if trails log data events for S3 buckets is not configured."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CLOUDTRAIL_S3_DATAEVENTS_ENABLED"
  }
}

resource "aws_config_config_rule" "CloudwatchLog-GroupEncrypted" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cloudwatchlog-group-encrypted"

  description = "Checks whether a log group in Amazon CloudWatch Logs is encrypted. The rule is NON_COMPLIANT if CloudWatch Logs has log group without encryption enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CLOUDWATCH_LOG_GROUP_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "CmkBackingKeyRotationEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "cmk-backing-keyrotation-enabled"

  description = "Checks that key rotation is enabled for each key and matches to the key ID of the customer created customer master key (CMK). The rule is compliant, if the key rotation is enabled for specific key object."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "CMK_BACKING_KEY_ROTATION_ENABLED"
  }
}

resource "aws_config_config_rule" "CodebuildProject-EnvvarAwscredCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "codebuild-projectenvvar-awscred-check"

  description = "Checks whether the project contains environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. The rule is NON_COMPLIANT when the project environment variables contains plaintext credentials."

  scope {
    compliance_resource_types = ["AWS::CodeBuild::Project"]
  }

  source {
    owner            = "AWS"
    source_identifier = "CODEBUILD_PROJECT_ENVVAR_AWSCRED_CHECK"
  }
}

resource "aws_config_config_rule" "CodebuildProject-SourceRepoUrlCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "codebuild-project-sourcerepo-url-check"

  description = "Checks whether the GitHub or Bitbucket source repository URL contains either personal access tokens or user name and password. The rule is complaint with the usage of OAuth to grant authorization for accessing GitHub or Bitbucket repositories."

  scope {
    compliance_resource_types = ["AWS::CodeBuild::Project"]
  }

  source {
    owner            = "AWS"
    source_identifier = "CODEBUILD_PROJECT_SOURCE_REPO_URL_CHECK"
  }
}


resource "aws_config_config_rule" "Dms-ReplicationNotPublic" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "dms-replication-notpublic"

  description = "Checks whether AWS Database Migration Service replication instances are public. The rule is NON_COMPLIANT if PubliclyAccessible field is True."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "DMS_REPLICATION_NOT_PUBLIC"
  }
}

resource "aws_config_config_rule" "DynamodbTableEncryptionEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "dynamodb-tableencryption-enabled"

  description = "Checks whether the Amazon DynamoDB tables are encrypted and checks their status. The rule is compliant if the status is enabled or enabling."

  scope {
    compliance_resource_types = ["AWS::DynamoDB::Table"]
  }

  source {
    owner            = "AWS"
    source_identifier = "DYNAMODB_TABLE_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "EbsSnapshot-PublicRestorableCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "ebs-snapshot-publicrestorable-check"

  description = "Checks whether Amazon Elastic Block Store (Amazon EBS) snapshots are not publicly restorable. The rule is NON_COMPLIANT if one or more snapshots with RestorableByUserIds field are set to all, that is, Amazon EBS snapshots are public."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "EBS_SNAPSHOT_PUBLIC_RESTORABLE_CHECK"
  }
}

resource "aws_config_config_rule" "Ec2Instance-ManagedBySsm" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "ec2-instance-managed-by-systemsmanager"

  description = "Checks whether the Amazon EC2 instances in your account are managed by AWS Systems Manager."

  scope {
    compliance_resource_types = ["AWS::EC2::Instance", "AWS::SSM::ManagedInstanceInventory"]
  }

  source {
    owner            = "AWS"
    source_identifier = "EC2_INSTANCE_MANAGED_BY_SSM"
  }
}

resource "aws_config_config_rule" "Ec2Instance-NoPublicIp" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "ec2instance-no-public-ip"

  description = "Checks whether Amazon Elastic Compute Cloud (Amazon EC2) instances have a public IP association. The rule is NON_COMPLIANT if the publicIp field is present in the Amazon EC2 instance configuration item. This rule applies only to IPv4."

  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }

  source {
    owner            = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }
}

resource "aws_config_config_rule" "Ec2Managedinstance-AssociationComplianceStatusCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "ec2managedinstance-association-compliance-status-check"

  description = "Checks whether the compliance status of the AWS Systems Manager association compliance is COMPLIANT or NON_COMPLIANT after the association execution on the instance. The rule is compliant if the field status is COMPLIANT."

  scope {
    compliance_resource_types = ["AWS::SSM::AssociationCompliance"]
  }

  source {
    owner            = "AWS"
    source_identifier = "EC2_MANAGEDINSTANCE_ASSOCIATION_COMPLIANCE_STATUS_CHECK"
  }
}

resource "aws_config_config_rule" "Ec2Managedinstance-PatchComplianceStatusCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "ec2managedinstance-patch-compliance-status-check"

  description = "Checks whether the compliance status of the AWS Systems Manager patch compliance is COMPLIANT or NON_COMPLIANT after the patch installation on the instance. The rule is compliant if the field status is COMPLIANT."

  scope {
    compliance_resource_types = ["AWS::SSM::PatchCompliance"]
  }

  source {
    owner            = "AWS"
    source_identifier = "EC2_MANAGEDINSTANCE_PATCH_COMPLIANCE_STATUS_CHECK"
  }
}

resource "aws_config_config_rule" "Ec2SecurityGroup-AttachedToEni" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "ec2security-group-attached-to-eni"

  description = "Checks that non-default security groups are attached to Amazon Elastic Compute Cloud (EC2) instances or an elastic network interfaces (ENIs). The rule returns NON_COMPLIANT if the security group is not associated with an EC2 instance or an ENI."

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "EC2_SECURITY_GROUP_ATTACHED_TO_ENI"
  }
}

resource "aws_config_config_rule" "Efs-EncryptedCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "efsencrypted-check"

  description = "Checks whether Amazon EFS are configured to encrypt file data using AWS KMS. The rule is NON_COMPLIANT if the Encrypted key is set to False on DescribeFileSystems or, if specified, KmsKeyId key on DescribeFileSystems is not matching KmsKeyId parameter."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "EFS_ENCRYPTED_CHECK"
  }
}

resource "aws_config_config_rule" "Eip-Attached" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "eipattached"

  description = "Checks whether all EIP addresses allocated to a VPC are attached to EC2 instances or in-use ENIs."

  scope {
    compliance_resource_types = ["AWS::EC2::EIP"]
  }

  source {
    owner            = "AWS"
    source_identifier = "EIP_ATTACHED"
  }
}

resource "aws_config_config_rule" "Elasticsearch-EncryptedAtRest" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "elasticsearchencrypted-at-rest"

  description = "Checks whether Amazon Elasticsearch Service (Amazon ES) domains have encryption at rest configuration enabled. The rule is NON_COMPLIANT if EncryptionAtRestOptions field is not enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "ELASTICSEARCH_ENCRYPTED_AT_REST"
  }
}

resource "aws_config_config_rule" "Elasticsearch-InVpcOnly" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "elasticsearchin-vpc-only"

  description = "Checks whether Amazon Elasticsearch Service domains are in Amazon Virtual Private Cloud (VPC). The rule is NON_COMPLIANT if ElasticSearch Service domain endpoint is public."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "ELASTICSEARCH_IN_VPC_ONLY"
  }
}

resource "aws_config_config_rule" "Elb-AcmCertificateRequired" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "elb-acm-certificaterequired"

  description = "This rule checks whether the Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager. You must use an SSL or HTTPS listener with your Elastic Load Balancer to use this rule."

  scope {
    compliance_resource_types = ["AWS::ElasticLoadBalancing::LoadBalancer"]
  }

  source {
    owner            = "AWS"
    source_identifier = "ELB_ACM_CERTIFICATE_REQUIRED"
  }
}

resource "aws_config_config_rule" "ElbLogging-Enabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "elb-loggingenabled"

  description = "Checks whether the Application Load Balancers and the Classic Load Balancers have logging enabled."

  scope {
    compliance_resource_types = ["AWS::ElasticLoadBalancing::LoadBalancer", "AWS::ElasticLoadBalancingV2::LoadBalancer"]
  }

  source {
    owner            = "AWS"
    source_identifier = "ELB_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "EmrKerberos-Enabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "emrkerberos-enabled"

  description = "The rule is NON_COMPLIANT if a security configuration is not attached to the cluster or the security configuration does not satisfy the specified rule parameters."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "EMR_KERBEROS_ENABLED"
  }
}

resource "aws_config_config_rule" "EmrMaster-NoPublicIp" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "emr-masterno-public-ip"

  description = "Checks whether Amazon Elastic MapReduce (EMR) clusters' master nodes have public IPs. The rule is NON_COMPLIANT if the master node has a public IP."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "EMR_MASTER_NO_PUBLIC_IP"
  }
}

resource "aws_config_config_rule" "Encrypted-Volumes" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "encryptedvolumes"

  description = "Checks whether EBS volumes that are in an attached state are encrypted."

  scope {
    compliance_resource_types = ["AWS::EC2::Volume"]
  }

  source {
    owner            = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }
}

resource "aws_config_config_rule" "Guardduty-EnabledCentralized" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "guarddutyenabled-centralized"

  description = "Checks whether GuardDuty is enabled. You can optionally verify that the results are centralized in a specific AWS Account."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "GUARDDUTY_ENABLED_CENTRALIZED"
  }
}

resource "aws_config_config_rule" "Iam-PasswordPolicy" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "iam-passwordpolicy"

  description = "Checks whether the account password policy for IAM users meets the specified requirements."

  input_parameters = jsonencode({
    MaxPasswordAge            = "90"
    MinimumPasswordLength     = "7"
    PasswordReusePrevention   = "4"
    RequireLowercaseCharacters = "true"
    RequireNumbers            = "true"
    RequireSymbols            = "true"
    RequireUppercaseCharacters = "true"
  })

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
}

resource "aws_config_config_rule" "IamPolicy-NoStatementsWithAdminAccess" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "iam-policy-no-statementswithadmin-access"

  description = "Checks whether the default version of AWS Identity and Access Management (IAM) policies do not have administrator access. If any statement has Effect: Allow with Action: * over Resource: *, the rule is non-compliant."

  scope {
    compliance_resource_types = ["AWS::IAM::Policy"]
  }

  source {
    owner            = "AWS"
    source_identifier = "IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS"
  }
}

resource "aws_config_config_rule" "IamRootAccessKey-Check" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "iam-root-accesskey-check"

  description = "Checks whether the root user access key is available. The rule is compliant if the user access key does not exist."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }
}

resource "aws_config_config_rule" "IamUser-MfaEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "iam-user-mfaenabled"

  description = "Checks whether the AWS Identity and Access Management users have multi-factor authentication (MFA) enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "IamUserNo-PoliciesCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "iam-user-nopolicies-check"

  description = "Checks that none of your IAM users have policies attached. IAM users must inherit permissions from IAM groups or roles."

  scope {
    compliance_resource_types = ["AWS::IAM::User"]
  }

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }
}

resource "aws_config_config_rule" "IamUserUnused-CredentialsCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "iam-user-unusedcredentials-check"

  description = "Checks whether your AWS Identity and Access Management (IAM) users have passwords or active access keys that have not been used within the specified number of days you provided."

  input_parameters = jsonencode({
    maxCredentialUsageAge = "90"
  })

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = []
  }

  source {
    owner            = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }
}

resource "aws_config_config_rule" "Incoming-SshDisabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "restrictedssh"

  description = "Checks whether security groups that are in use disallow unrestricted incoming SSH traffic."

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }
}

resource "aws_config_config_rule" "InternetGateway-AuthorizedVpcOnly" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "internet-gateway-authorizedvpc-only"

  description = "Checks that Internet gateways (IGWs) are only attached to an authorized Amazon Virtual Private Cloud (VPCs). The rule is NON_COMPLIANT if IGWs are not attached to an authorized VPC."

  scope {
    compliance_resource_types = ["AWS::EC2::InternetGateway"]
  }

  source {
    owner            = "AWS"
    source_identifier = "INTERNET_GATEWAY_AUTHORIZED_VPC_ONLY"
  }
}

resource "aws_config_config_rule" "LambdaFunctionPublicAccessProhibited" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "lambda-function-publicaccess-prohibited"

  description = "Checks whether the Lambda function policy prohibits public access."

  scope {
    compliance_resource_types = ["AWS::Lambda::Function"]
  }

  source {
    owner            = "AWS"
    source_identifier = "LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED"
  }
}

resource "aws_config_config_rule" "LambdaInsideVpc" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "lambdainside-vpc"

  description = "Checks whether an AWS Lambda function is in an Amazon Virtual Private Cloud (VPC). The rule is NON_COMPLIANT if the Lambda function is not in a VPC."

  scope {
    compliance_resource_types = ["AWS::Lambda::Function"]
  }

  source {
    owner            = "AWS"
    source_identifier = "LAMBDA_INSIDE_VPC"
  }
}

resource "aws_config_config_rule" "MfaEnabledForIamConsoleAccess" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "mfa-enabled-for-iamconsole-access"

  description = "Checks whether AWS Multi-Factor Authentication (MFA) is enabled for all AWS Identity and Access Management (IAM) users that use a console password. The rule is compliant if MFA is enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }
}

resource "aws_config_config_rule" "RdsInstancePublicAccessCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "rds-instance-publicaccess-check"

  description = "Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible. The rule is non-compliant if the publiclyAccessible field is true in the instance configuration item."

  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }

  source {
    owner            = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }
}

resource "aws_config_config_rule" "RdsSnapshotsPublicProhibited" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "rds-snapshots-publicprohibited"

  description = "Checks if Amazon Relational Database Service (Amazon RDS) snapshots are public. The rule is non-compliant if any existing and new Amazon RDS snapshots are public."

  scope {
    compliance_resource_types = ["AWS::RDS::DBSnapshot", "AWS::RDS::DBClusterSnapshot"]
  }

  source {
    owner            = "AWS"
    source_identifier = "RDS_SNAPSHOTS_PUBLIC_PROHIBITED"
  }
}

resource "aws_config_config_rule" "RdsStorageEncrypted" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "rds-storageencrypted"

  description = "Checks whether storage encryption is enabled for your RDS DB instances."

  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }

  source {
    owner            = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "RedshiftClusterConfigurationCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "redshift-clusterconfiguration-check"

  description = "Checks whether Amazon Redshift clusters have the specified settings."

  input_parameters = jsonencode({
    clusterDbEncrypted = "TRUE"
    loggingEnabled     = "TRUE"
  })

  scope {
    compliance_resource_types = ["AWS::Redshift::Cluster"]
  }

  source {
    owner            = "AWS"
    source_identifier = "REDSHIFT_CLUSTER_CONFIGURATION_CHECK"
  }
}

resource "aws_config_config_rule" "RedshiftClusterPublicAccessCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "redshift-cluster-publicaccess-check"

  description = "Checks whether Amazon Redshift clusters are not publicly accessible. The rule is NON_COMPLIANT if the publiclyAccessible field is true in the cluster configuration item."

  scope {
    compliance_resource_types = ["AWS::Redshift::Cluster"]
  }

  source {
    owner            = "AWS"
    source_identifier = "REDSHIFT_CLUSTER_PUBLIC_ACCESS_CHECK"
  }
}

resource "aws_config_config_rule" "RedshiftRequireTlsSsl" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "redshift-requiretls-ssl"

  description = "Checks whether Amazon Redshift clusters require TLS/SSL encryption to connect to SQL clients. The rule is NON_COMPLIANT if any Amazon Redshift cluster has parameter require_SSL not set to true."

  scope {
    compliance_resource_types = ["AWS::Redshift::Cluster"]
  }

  source {
    owner            = "AWS"
    source_identifier = "REDSHIFT_REQUIRE_TLS_SSL"
  }
}

resource "aws_config_config_rule" "RestrictedIncomingTraffic" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "restrictedcommon-ports"

  description = "Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."

  input_parameters = jsonencode({
    blockedPort1 = "20"
    blockedPort2 = "21"
    blockedPort3 = "3389"
    blockedPort4 = "3306"
    blockedPort5 = "4333"
  })

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }
}

resource "aws_config_config_rule" "RootAccountHardwareMfaEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "root-accounthardware-mfa-enabled"

  description = "Checks whether your AWS account is enabled to use multi-factor authentication (MFA) hardware device to sign in with root credentials."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "ROOT_ACCOUNT_HARDWARE_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "RootAccountMfaEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "root-accountmfa-enabled"

  description = "Checks whether the root user of your AWS account requires multi-factor authentication for console sign-in."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "S3AccountLevelPublicAccessBlocks" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3-account-levelpublic-access-blocks"

  description = "Checks whether the required public access block settings are configured from account level. The rule is NON COMPLIANT when the public access block settings are not configured from account level."

  input_parameters = jsonencode({
    BlockPublicAcls       = "true"
    BlockPublicPolicy     = "true"
    IgnorePublicAcls      = "true"
    RestrictPublicBuckets = "true"
  })

  scope {
    compliance_resource_types = ["AWS::S3::AccountPublicAccessBlock"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_ACCOUNT_LEVEL_PUBLIC_ACCESS_BLOCKS"
  }
}

resource "aws_config_config_rule" "S3Bucket--LoggingEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3-bucketlogging-enabled"

  description = "Checks whether logging is enabled for your S3 buckets."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "S3BucketPolicyGranteeCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3-bucketpolicy-grantee-check"

  description = "Checks that the access granted by the Amazon S3 bucket is restricted to any of the AWS principals, federated users, service principals, IP addresses, or VPCs that you provide. The rule is COMPLIANT if a bucket policy is not present."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_POLICY_GRANTEE_CHECK"
  }
}

resource "aws_config_config_rule" "S3Bucket-PublicReadProhibited" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3-bucketpublic-read-prohibited"

  description = "Checks that your Amazon S3 buckets do not allow public read access. The rule checks the Block Public Access settings, the bucket policy, and the bucket access control list (ACL)."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}

resource "aws_config_config_rule" "S3Bucket-PublicWriteProhibited" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3-bucketpublic-write-prohibited"

  description = "Checks that your Amazon S3 buckets do not allow public write access. The rule checks the Block Public Access settings, the bucket policy, and the bucket access control list (ACL)."

  maximum_execution_frequency = "TwentyFour_Hours"

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
}

resource "aws_config_config_rule" "S3BucketServerSideEncryptionEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3-bucketserver-side-encryption-enabled"

  description = "Checks that your Amazon S3 bucket either has S3 default encryption enabled or that the S3 bucket policy explicitly denies put-object requests without server side encryption."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "S3BucketSslRequestsOnly" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3bucket-ssl-requests-only"

  description = "Checks whether S3 buckets have policies that require requests to use Secure Socket Layer (SSL)."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }
}

resource "aws_config_config_rule" "S3BucketVersioningEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "s3bucket-versioning-enabled"

  description = "Checks whether versioning is enabled for your S3 buckets."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }
}

resource "aws_config_config_rule" "SagemakerEndpointConfigurationKmsKeyConfigured" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "sagemaker-endpoint-configuration-kmskey-configured"

  description = "Checks whether AWS Key Management Service (KMS) key is configured for an Amazon SageMaker endpoint configuration. The rule is NON_COMPLIANT if 'KmsKeyId' is not specified for the Amazon SageMaker endpoint configuration."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "SAGEMAKER_ENDPOINT_CONFIGURATION_KMS_KEY_CONFIGURED"
  }
}

resource "aws_config_config_rule" "SagemakerNotebookInstanceKmsKeyConfigured" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "sagemaker-notebook-instance-kmskey-configured"

  description = "Check whether an AWS Key Management Service (KMS) key is configured for an Amazon SageMaker notebook instance. The rule is NON_COMPLIANT if 'KmsKeyId' is not specified for the Amazon SageMaker notebook instance."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "SAGEMAKER_NOTEBOOK_INSTANCE_KMS_KEY_CONFIGURED"
  }
}

resource "aws_config_config_rule" "SagemakerNotebookNoDirectInternetAccess" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "sagemaker-notebook-no-directinternet-access"

  description = "Checks whether direct internet access is disabled for an Amazon SageMaker notebook instance. The rule is NON_COMPLIANT if Amazon SageMaker notebook instances are internet-enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "SAGEMAKER_NOTEBOOK_NO_DIRECT_INTERNET_ACCESS"
  }
}

resource "aws_config_config_rule" "SecretsmanagerRotationEnabledCheck" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "secretsmanager-rotationenabled-check"

  description = "Checks whether AWS Secret Manager secret has rotation enabled. If the maximumAllowedRotationFrequency parameter is specified, the rotation frequency of the secret is compared with the maximum allowed frequency."

  scope {
    compliance_resource_types = ["AWS::SecretsManager::Secret"]
  }

  source {
    owner            = "AWS"
    source_identifier = "SECRETSMANAGER_ROTATION_ENABLED_CHECK"
  }
}

resource "aws_config_config_rule" "SecurityhubEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "securityhubenabled"

  description = "Checks that AWS Security Hub is enabled for an AWS Account. The rule is NON_COMPLIANT if AWS Security Hub is not enabled."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "SECURITYHUB_ENABLED"
  }
}

resource "aws_config_config_rule" "VpcDefaultSecurityGroupClosed" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "vpc-default-securitygroup-closed"

  description = "Checks that the default security group of any Amazon Virtual Private Cloud (VPC) does not allow inbound or outbound traffic. The rule is non-compliant if the default security group has one or more inbound or outbound traffic."

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"
  }
}

resource "aws_config_config_rule" "VpcFlowLogsEnabled" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "vpc-flowlogs-enabled"

  description = "Checks whether Amazon Virtual Private Cloud flow logs are found and enabled for Amazon VPC."

  maximum_execution_frequency = "TwentyFour_Hours"

  source {
    owner            = "AWS"
    source_identifier = "VPC_FLOW_LOGS_ENABLED"
  }
}

resource "aws_config_config_rule" "VpcSgOpenOnlyToAuthorizedPorts" {
  count = strcontains(var.aws_configrules,"pci")? 1:0
  name = "vpc-sg-open-onlyto-authorized-ports"

  description = "Checks whether any security groups with inbound 0.0.0.0/0 have TCP or UDP ports accessible. The rule is NON_COMPLIANT when a security group with inbound 0.0.0.0/0 has a port accessible which is not specified in the rule parameters."

  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }

  source {
    owner            = "AWS"
    source_identifier = "VPC_SG_OPEN_ONLY_TO_AUTHORIZED_PORTS"
  }
}
