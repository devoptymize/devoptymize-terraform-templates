resource "aws_config_config_rule" "S3BucketPublicReadProhibited" {
  count = strcontains(var.aws_configrules,"s3")? 1:0
  name = "S3BucketPublicReadProhibited"
  description = "Checks that your Amazon S3 buckets do not allow public read access. The rule checks the Block Public Access settings, the bucket policy, and the bucket access control list (ACL)."
  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }

  maximum_execution_frequency = "Six_Hours"
}

resource "aws_config_config_rule" "S3BucketPublicWriteProhibited" {
  count = strcontains(var.aws_configrules,"s3")? 1:0
  name = "S3BucketPublicWriteProhibited"

  description = "Checks that your Amazon S3 buckets do not allow public write access. The rule checks the Block Public Access settings, the bucket policy, and the bucket access control list (ACL)."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }

  maximum_execution_frequency = "Six_Hours"
}

resource "aws_config_config_rule" "S3BucketReplicationEnabled" {
  count = strcontains(var.aws_configrules,"s3")? 1:0
  name = "S3BucketReplicationEnabled"

  description = "Checks whether the Amazon S3 buckets have cross-region replication enabled."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_REPLICATION_ENABLED"
  }
}

resource "aws_config_config_rule" "S3BucketSSLRequestsOnly" {
  count = strcontains(var.aws_configrules,"s3")? 1:0
  name = "S3BucketSSLRequestsOnly"

  description = "Checks whether S3 buckets have policies that require requests to use Secure Socket Layer (SSL)."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }
}

resource "aws_config_config_rule" "ServerSideReplicationEnabled" {
  count = strcontains(var.aws_configrules,"s3")? 1:0
  name = "ServerSideReplicationEnabled"

  description = "Checks that your Amazon S3 bucket either has S3 default encryption enabled or that the S3 bucket policy explicitly denies put-object requests without server side encryption."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "S3BucketLoggingEnabled" {
  count = strcontains(var.aws_configrules,"s3")? 1:0
  name = "S3BucketLoggingEnabled"

  description = "Checks whether logging is enabled for your S3 buckets."

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }

  source {
    owner            = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }
}
