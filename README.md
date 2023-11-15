# DevOptymize-Terraform-Templates

The DevOptymize-Terraform-Templates repository hosts the collection of Terraform Templates, which can be used to provision individual resources and blueprints on AWS.

### Features

- Ready to use templates, helps in provisioning AWS resource and blueprints effortlessly.
- Blue prints
  - [Amazon VPC Configuration Guide](./services/aws-vpc-config)
  - [AWS DevOps pipeline architecture - CI/CD of Static-website (S3 CDN stack)](./services/aws-cicd-sw)
  - [AWS DevOps Pipeline architecture - CI/CD for Nodejs backend application](./services/aws-cicd-ms)
  - [Refined 3-tier application architecture](./services/aws-3t-arch)
  - [Micro service architecture with EKS, S3 CDN and PSQL](./services/aws-eks-cdn)
  - [Amazon RDS on AWS](./services/aws-rds-stack)
  - [Fintech Blueprint on AWS](./services/aws-fintech)
  - [Three-Tier Architecture for Hosting WordPress on AWS](./services/aws-3t-wp)
- Resources
  - [Network](./services/network)
  - [Key Pair](./services/key-pair)
  - [Security Group](./services/security-group)
  - [EC2](./services/ec2)
  - [Launch Template](./services/launch-template)
  - [ASG](./services/asg)
  - [Target Group](./services/lb-target-group)
  - [Load Balancer](./services/lb)
  - [RDS](./services/rds)
  - [Route53](./services/route-53)
  - [S3](./services/s3)
  - [ECR](./services/ecr)
  - [EKS](./services/eks)
  - [RDS cluster](./services/rds-cluster)
  - [CloudFront](./services/cloudfront)
    
### Pre-Requisites

Dependencies to create the AWS resource using Terraform:

- Terraform 1.0.x or newer.

### Usage

Once the Variable and the Module is ready follow the below commands to create the resource

- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure.
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.

### Contributing

We welcome contributions from the community to enhance the terraform templates. If you would like to contribute, please follow our guidelines outlined in the [CONTRIBUTING.md](./CONTRIBUTING.md) file. You can submit feature requests, or pull requests to help us improve the template.

### License
