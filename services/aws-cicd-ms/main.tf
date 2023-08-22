// Data source to get current AWS caller identity
data "aws_caller_identity" "current" {}

// IAM role for CodePipeline service
resource "aws_iam_role" "pipeline_service_role" {
  name = "${var.environment}-${var.stack_name}-pipeline-role"
  description = "IAM role for AWS CodePipeline service"

  // Policy that allows CodePipeline to assume this role
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      }
    ]
  })
}

// IAM policy for CodePipeline
resource "aws_iam_policy" "codepipeline_policy" {
  name        = "${var.environment}-${var.stack_name}-Policy"
  description = "IAM policy for CodePipeline"

  // Policy rules defining what actions CodePipeline can perform
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "codepipeline:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "codecommit:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:CreateLogGroup"
        Resource = "arn:aws:logs:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:CreateLogStream"
        Resource = "arn:aws:logs:${data.aws_caller_identity.current.account_id}:log-group:/aws/codepipeline/*:log-stream:*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:PutLogEvents"
        Resource = "arn:aws:logs:${data.aws_caller_identity.current.account_id}:log-group:/aws/codepipeline/*:log-stream:*"
      },
      {
        Effect   = "Allow"
        Action   = "logs:DescribeLogStreams"
        Resource = "arn:aws:logs:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/*:log-stream:*"
      },
      {
        Effect   = "Allow"
        Action   = "codebuild:*"
        Resource = "*"
      },
     {
        Effect   = "Allow"
        Action   = "codestar-notifications:CreateNotificationRule"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "codestar-notifications:UpdateNotificationRule"
        Resource = "*"
      }
    ]
  })
}

// Attach CodePipeline policy to the CodePipeline service role
#IAM policy attachment granting necessary permissions to the AWS CodePipeline service role
resource "aws_iam_policy_attachment" "codepipeline_policy_attachment" {
  name       = "${var.environment}-${var.stack_name}-PolicyAttachment"
  roles      = [aws_iam_role.pipeline_service_role.name]
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}

// IAM role for CodeBuild service
#IAM role for AWS CodeBuild service to enable it to perform actions on behalf of the build projects.
resource "aws_iam_role" "codebuild_service_role" {
  name = "${var.environment}-${var.stack_name}-servicerole"

  // Policy that allows CodeBuild to assume this role
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
      }
    ]
  })
}

// IAM policy attachments for CodeBuild service role
#IAM policy attachment granting AWSCodeBuildDeveloperAccess to the AWS CodeBuild service role.
resource "aws_iam_policy_attachment" "codebuild_policy_attachment" {
  name       = "${var.environment}-${var.stack_name}-PolicyAttachment"
  roles      = [aws_iam_role.codebuild_service_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}
#IAM policy attachment granting CloudWatchFullAccess to the AWS CodeBuild service role.
resource "aws_iam_policy_attachment" "codebuild_cloudwatch_attachment" {
  name       = "${var.environment}-${var.stack_name}-CloudWatchAttachment"
  roles      = [aws_iam_role.codebuild_service_role.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
#IAM policy attachment granting AmazonS3FullAccess to the AWS CodeBuild service role.
resource "aws_iam_policy_attachment" "codebuild_s3_attachment" {
  name       = "${var.environment}-${var.stack_name}-S3Attachment"
  roles      = [aws_iam_role.codebuild_service_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy_attachment" "codebuild_ecr_attachment" {
  name       = "${var.environment}-${var.stack_name}-ECRAttachment"
  roles      = [aws_iam_role.codebuild_service_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}


//bucketforartifact
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${var.environment}-${var.stack_name}-artifact-bucket"
  force_destroy = true

}

// Define CodeCommit repository
resource "aws_codecommit_repository" "codecommit_repo" {
  repository_name = var.repository_name
  description     = "repository for ${var.environment}-${var.stack_name}" 
}

// Define CodeBuild project
resource "aws_codebuild_project" "codebuild_project" {
  name          = "${var.environment}-${var.stack_name}-project"
  service_role  = aws_iam_role.codebuild_service_role.arn

  // Source configuration for the CodeBuild project
  source {
    type = "CODEPIPELINE"
  }

  // Artifact configuration for the CodeBuild project
  artifacts {
    type = "CODEPIPELINE"  # Output artifact of the Build stage
  }

  // Environment configuration for the CodeBuild project
  environment {
    compute_type = var.compute_type
    type         = var.type
    image        = var.image
    privileged_mode = true

    
  }
}

// Define CodePipeline
resource "aws_codepipeline" "codepipeline" {
  name     = "${var.environment}-${var.stack_name}-pipeline"
  role_arn = aws_iam_role.pipeline_service_role.arn

  // Artifact store configuration for CodePipeline
  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact_bucket.bucket
  }

  // Source stage for CodePipeline
  stage {
    name = "Source"

    action {
      name     = "SourceAction"
      category = "Source"
      owner    = "AWS"
      provider = "CodeCommit"
      version  = "1"

      configuration = {
        RepositoryName     = var.repository_name
        BranchName         = var.branch_name  # Change to your desired branch name
        PollForSourceChanges = false
      }

      output_artifacts = ["SourceArtifact"]
    }
  }

  // Build stage for CodePipeline
  stage {
    name = "Build"

    action {
      name     = "BuildAction"
      category = "Build"
      owner    = "AWS"
      provider = "CodeBuild"
      version  = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild_project.name
      }

      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
    }
  }


}



// Define SNS topic for CodePipeline notifications
resource "aws_sns_topic" "sns_topic" {
  name        = "${var.environment}-${var.stack_name}-CodePipelineNotifications"
  display_name = "${var.environment}-${var.stack_name} CodePipeline Notifications"
}
resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.sns_topic.arn

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "SnsTopicPolicy",
    Statement = [
      {
        Sid       = "AllowCodeStarNotifications",
        Effect    = "Allow",
        Principal = {
          Service = "codestar-notifications.amazonaws.com"
        },
        Action    = "SNS:Publish",
        Resource  = aws_sns_topic.sns_topic.arn
      }
      // You can add more statements as needed
    ]
  })
}
// Define SNS topic subscription for CodePipeline notifications
resource "aws_sns_topic_subscription" "sns_subscription" {
  for_each = { for email in var.emails : email => email }
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_codestarnotifications_notification_rule" "example_notification_rule" {
  name        = "${var.environment}-${var.stack_name}-notification-rule"
  detail_type = "BASIC"
  resource    = aws_codepipeline.codepipeline.arn

  event_type_ids = [
    "codepipeline-pipeline-pipeline-execution-failed",
    "codepipeline-pipeline-pipeline-execution-canceled",
    "codepipeline-pipeline-pipeline-execution-started",
    "codepipeline-pipeline-pipeline-execution-succeeded",
  ]

  target {
    address     = aws_sns_topic.sns_topic.arn
  }
}

// Output the ARN of the CodePipeline service role
output "pipeline_service_role_arn" {
  description = "ARN of the CodePipeline Service Role"
  value       = aws_iam_role.pipeline_service_role.arn
}

