##  Elastic Kubernetes Service (EKS) on AWS using Terraform Template

- This Terraform template is designed for creating and managing Elastic Kubernetes Service (EKS) on Amazon Web Services (AWS). Amazon Elastic Kubernetes Service (Amazon EKS) is a fully managed container orchestration service that simplifies the deployment, management, and scaling of containerized applications using Kubernetes. It provides a highly available and secure platform to run, manage, and scale containerized workloads with ease.
- The main.tf, variable.tf, provider.tf, and backend.tf files are typically used in a Terraform project to organize and configure your infrastructure code. 

## Installation
Dependencies to create the AWS resource using Terraform: 
- Make sure Terraform is installed

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.15.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.0 |
| <a name="module_eks_managed_node_group"></a> [eks\_managed\_node\_group](#module\_eks\_managed\_node\_group) | terraform-aws-modules/eks/aws//modules/eks-managed-node-group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Controls whether the EKS cluster's API server endpoint should have private access. Set to true for private access and false for public access | `bool` | `null` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Controls whether the EKS cluster's API server endpoint should have public access. Set to true for public access and false for private access | `bool` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment | `string` | `""` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Type of the instance | `string` | `""` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The provisioned IOPS for a storage volume | `number` | `null` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Version of the EKS cluster | `string` | `""` | no |
| <a name="input_log_types"></a> [log\_types](#input\_log\_types) | A list of the desired control plane logs to enable. | `list(string)` | `[]` | no |
| <a name="input_node_capacity_type"></a> [node\_capacity\_type](#input\_node\_capacity\_type) | The instance capacity type for creating EKS node group | `string` | `""` | no |
| <a name="input_node_group_desired_size"></a> [node\_group\_desired\_size](#input\_node\_group\_desired\_size) | The desired node count for setting up EKS node group | `number` | `null` | no |
| <a name="input_node_group_max_size"></a> [node\_group\_max\_size](#input\_node\_group\_max\_size) | The maximum node count for setting up EKS node group | `number` | `null` | no |
| <a name="input_node_group_min_size"></a> [node\_group\_min\_size](#input\_node\_group\_min\_size) | The minimum node count for setting up EKS node group | `number` | `null` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | Name of the node group | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Name of the region | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | subnet id for creating EKS cluster | `list(string)` | `[]` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the volume to attach | `number` | `null` | no |
| <a name="input_volume_type"></a> [volume\_type](#input\_volume\_type) | Type of the volume | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | vpc id for creating EKS cluster | `string` | `""` | no |

### Usage
Once the Variable and the Module is ready follow the below commands to create the resource
- ```terraform init``` to download the modules
- ```terraform plan``` to generate an execution plan for your infrastructure. 
- ```terraform apply``` to apply the changes and create the infrastructure.
- ```terraform destroy``` to delete the resource which is created through terraform.
