## Data Block For availability Zone ##
data "aws_availability_zones" "available" {
    state = "available"
}


module "production_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.stack_name}-prod-vpc"
  cidr = var.vpc_production_cidr


  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = var.production_private_cidr
  public_subnets  = var.production_public_cidr
  create_database_subnet_group = false
  create_database_subnet_route_table= true
  database_subnets     = var.production_isolated_cidr

  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = false
  

}

module "management_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.stack_name}-mngmnt-vpc"
  cidr = var.vpc_management_cidr


  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = var.management_private_cidr
  public_subnets  = var.management_public_cidr

  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = false
 

}

module "development_vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.stack_name}-dev-vpc"
  cidr = var.vpc_development_cidr


  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = var.development_private_cidr
  public_subnets  = var.development_public_cidr
  create_database_subnet_group = false
  create_database_subnet_route_table= true
  database_subnets     = var.development_isolated_cidr


  enable_dns_hostnames = true

  enable_nat_gateway = true
  single_nat_gateway = false


}
################################################ CLIENT VPN ##############################################################
resource "aws_ec2_client_vpn_endpoint" "management_vpn" {
  description            = "${var.stack_name}-aws-client-vpn"
  server_certificate_arn = var.server_certification
  client_cidr_block      = var.clientcidrblock
  vpc_id                 = module.management_vpc.vpc_id

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.clientrootcertificate
  }
    connection_log_options {
    enabled               = false
    }
}

################################################# PEERING CONNECTIONS ##################################
resource "aws_vpc_peering_connection" "production_to_management" {
  peer_vpc_id          = module.production_vpc.vpc_id
  vpc_id               = module.management_vpc.vpc_id
  auto_accept          = true  # You can set this to false if you want to manually accept the peering connection
  tags = {
    Name = "${var.stack_name}-prod-to-mngmnt-peering"
  }
}

# Create a route table entry in the PRODUCTION-VPC's route table to route traffic to the MANAGEMENT-VPC via the peering connection
resource "aws_route" "production_to_management" {
  route_table_id            = module.production_vpc.private_route_table_ids[0] # Replace with the actual route table ID for your private subnet
  destination_cidr_block    = module.management_vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.production_to_management.id
}

resource "aws_vpc_peering_connection" "management_to_development" {
  peer_vpc_id          = module.management_vpc.vpc_id
  vpc_id               = module.development_vpc.vpc_id
  auto_accept          = true  # You can set this to false if you want to manually accept the peering connection
  tags = {
    Name = "${var.stack_name}-mngmnt-to-dev-peering"
  }
}

# Create a route table entry in the MANAGEMENT-VPC's route table to route traffic to the DEVELOPMENT-VPC via the peering connection
resource "aws_route" "management_to_development" {
  route_table_id            = module.management_vpc.private_route_table_ids[0] # Replace with the actual route table ID for your private subnet in MANAGEMENT-VPC
  destination_cidr_block    = module.development_vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.management_to_development.id
}

resource "aws_vpc_peering_connection" "development_to_production" {
  peer_vpc_id          = module.development_vpc.vpc_id
  vpc_id               = module.production_vpc.vpc_id
  auto_accept          = true  # You can set this to false if you want to manually accept the peering connection
  tags = {
    Name = "${var.stack_name}-dev-to-prod-peering"
  }
}

# Create a route table entry in the DEVELOPMENT-VPC's route table to route traffic to the PRODUCTION-VPC via the peering connection
resource "aws_route" "development_to_production" {
  route_table_id            = module.development_vpc.private_route_table_ids[0] # Replace with the actual route table ID for your private subnet in DEVELOPMENT-VPC
  destination_cidr_block    = module.production_vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.development_to_production.id
}

