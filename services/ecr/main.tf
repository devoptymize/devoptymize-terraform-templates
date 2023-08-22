module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = var.ecr_repo_name

  #Image tag immutability to prevent image tags from being overwritten by subsequent image pushes
  repository_image_tag_mutability = var.repository_image_tag_mutability

  #Type of repository which is either public or private
  repository_type = var.repository_type

  #scan on push to have each image automatically scanned after being pushed to a repository
  repository_image_scan_on_push = var.scan_repo

   #Read_write_write_access
  repository_read_write_access_arns = var.repository_type == "private" ? var.read_write_access_arns : []

  #Read_write_access
  repository_read_access_arns = var.repository_type == "private" ? var.read_access_arns : []

  #Lifecycle policy
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last ${var.image_count} images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = "${var.image_count}"
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
