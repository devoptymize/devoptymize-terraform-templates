 # module "eks" for creating cluster using terraform registry 
  module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name    = var.cluster_name #EKS cluster name
  cluster_version = var.k8s_version #EKS cluster version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access #Enabling cluster endpoint private access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access  #disabling endpoint public access
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_id
  create_iam_role = true #Creating cluster role
  iam_role_name = "${var.environment}-${var.cluster_name}-eks-role" #name for cluster role
  cluster_enabled_log_types = var.log_types


  
# aws-auth configmap to add role-based access control (RBAC) access to IAM users and roles
  create_aws_auth_configmap = false
  manage_aws_auth_configmap = false


#Creating additional security group for cluster
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
    ingress_nodes_ports_tcp = {
      description                = "Allow the pods to communicate with the cluster API Server"
      protocol                   = "tcp"
      from_port                  = 443
      to_port                    = 443
      type                       = "egress"
      source_node_security_group = true
    }
    egress_all = {
      description      = "Cluster all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
    ingress_with_source_security_group_id = {
      description                  = "Allow communication to the cluster API Server"
      protocol                     = "tcp"
      from_port                    = 443
      to_port                      = 443
      type                         = "ingress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }
  }


#Creating Node Group
module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  name            = var.node_group_name
  cluster_name    = module.eks.cluster_name 
  cluster_version = var.k8s_version

  subnet_ids = var.subnet_id
  vpc_security_group_ids = [module.eks.node_security_group_id]
  min_size     = var.node_group_min_size
  max_size     = var.node_group_max_size
  desired_size = var.node_group_desired_size
  instance_types = [var.instance_type]
  capacity_type  = var.node_capacity_type
  use_custom_launch_template = false

  # To Encrypt the root volume
  block_device_mappings = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        volume_size           = var.volume_size
        volume_type           = var.volume_type
        iops                  = var.iops
        encrypted             = false
        delete_on_termination = true
      }
    }
  }
  metadata_options = {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
}

