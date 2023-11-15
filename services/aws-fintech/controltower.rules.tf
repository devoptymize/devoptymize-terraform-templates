resource "aws_config_config_rule" "CheckForEbsOptimizedInstance" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForEbsOptimizedInstance"
  description = "Disallow launch of EC2 instance types that are not EBS-optimized - Checks whether EBS optimization is enabled for your EC2 instances that can be EBS-optimized"
  source {
    owner             = "AWS"
    source_identifier = "EBS_OPTIMIZED_INSTANCE"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Instance"]
  }
}

resource "aws_config_config_rule" "CheckForEc2VolumesInUse" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForEc2VolumesInUs"
  description = "Disallow EBS volumes that are unattached to an EC2 instance - Checks whether EBS volumes are attached to EC2 instances"
  input_parameters = jsonencode({
    deleteOnTermination = "true"
  })
  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Volume"]
  }
}

resource "aws_config_config_rule" "CheckForEncryptedVolumes" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForEncryptedVolumes"
  description = "Enable encryption for EBS volumes attached to EC2 instances - Checks whether EBS volumes that are in an attached state are encrypted."
  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::Volume"]
  }
}

resource "aws_config_config_rule" "CheckForIAMUserMFA" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForIAMUserMFA"
  description = "Disallow access to IAM users without MFA - Checks whether the AWS Identity and Access Management users have multi-factor authentication (MFA) enabled. The rule is COMPLIANT if MFA is enabled."
  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }
  maximum_execution_frequency = "One_Hour"
}

resource "aws_config_config_rule" "CheckForIAMUserConsoleMFA" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForIAMUserConsoleMFA"
  description = "Disallow console access to IAM users without MFA - Checks whether AWS Multi-Factor Authentication (MFA) is enabled for all AWS Identity and Access Management (IAM) users that use a console password. The rule is COMPLIANT if MFA is enabled."
  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }
  maximum_execution_frequency = "One_Hour"
}

resource "aws_config_config_rule" "CheckForRdsPublicAccess" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForRdsPublicAccess"
  description = "Disallow public access to RDS database instances - Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible. The rule is non-compliant if the publiclyAccessible field is true in the instance configuration item."
  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "CheckForPublicRdsSnapshots" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForPublicRdsSnapshots"
  description = "Disallow public access to RDS database snapshots - Checks if Amazon Relational Database Service (Amazon RDS) snapshots are public. The rule is non-compliant if any existing and new Amazon RDS snapshots are public."
  source {
    owner             = "AWS"
    source_identifier = "RDS_SNAPSHOTS_PUBLIC_PROHIBITED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBSnapshot"]
  }
}

resource "aws_config_config_rule" "CheckForRdsStorageEncryption" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForRdsStorageEncryption"
  description = "Disallow RDS database instances that are not storage encrypted - Checks whether storage encryption is enabled for your RDS DB instances."
  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }
  scope {
    compliance_resource_types = ["AWS::RDS::DBInstance"]
  }
}

resource "aws_config_config_rule" "CheckForRestrictedCommonPortsPolicy" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForRestrictedCommonPortsPolicy"
  description = "Disallow internet connection through RDP - Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."
  input_parameters = jsonencode({
    blockedPort1 = "20"
    blockedPort2 = "21"
    blockedPort3 = "3389"
    blockedPort4 = "3306"
    blockedPort5 = "4333"
  })
  source {
    owner             = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}

resource "aws_config_config_rule" "CheckForRestrictedSshPolicy" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForRestrictedSshPolicy"
  description = "Disallow internet connection through SSH - Checks whether security groups that are in use disallow unrestricted incoming SSH traffic."
  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }
  scope {
    compliance_resource_types = ["AWS::EC2::SecurityGroup"]
  }
}

resource "aws_config_config_rule" "CheckForRootMfa" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForRootMfa"
  description = "Enable MFA for the root user - Checks whether the root user of your AWS account requires multi-factor authentication for console sign-in."
  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }
  maximum_execution_frequency = "One_Hour"
}

resource "aws_config_config_rule" "CheckForS3PublicRead" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForS3PublicRead"
  description = "Disallow public read access to S3 buckets - Checks that your S3 buckets do not allow public read access. If an S3 bucket policy or bucket ACL allows public read access, the bucket is noncompliant."
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
}

resource "aws_config_config_rule" "CheckForS3PublicWrite" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForS3PublicWrite"
  description = "Disallow public write access to S3 buckets - Checks that your S3 buckets do not allow public write access. If an S3 bucket policy or bucket ACL allows public write access, the bucket is noncompliant."
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
}

resource "aws_config_config_rule" "CheckForS3VersioningEnabled" {
  count = strcontains(var.aws_configrules,"controltower")? 1:0
  name        = "CheckForS3VersioningEnabled"
  description = "Disallow S3 buckets that are not versioning enabled - Checks whether versioning is enabled for your S3 buckets."
  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
}
