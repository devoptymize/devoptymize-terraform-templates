module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "3.10.1"
  bucket = var.bucket_name
  versioning = {
    enabled = true
  }
  block_public_acls = true
  block_public_policy = true
  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled = var.bucket_key_enabled
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256" # Use SSE-S3 encryption
      }
    }
  }
  attach_policy = true
  policy  = jsonencode(var.bucket_policy)
}
