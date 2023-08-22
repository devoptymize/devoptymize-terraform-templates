## Terraform module for creating the network part ##
module "network" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"
  name = "${var.environment}-${var.stack_name}-vpc"
  cidr   = var.vpc_cidr_range

  public_subnets        = var.public_subnets
  private_subnets       = var.private_subnets
  azs                   = data.aws_availability_zones.available.names

  # Database Subnets
  create_database_subnet_group = true
  create_database_subnet_route_table= true
  database_subnets     = var.database_private_subnets

  enable_dns_hostnames    = true
  enable_nat_gateway      = true
  single_nat_gateway      = false  # Set to false to create NAT gateway per AZ
  one_nat_gateway_per_az  = true   # Set to true to create NAT gateway per AZ
 
  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

}

resource "aws_vpc_endpoint" "endpoint" {
  vpc_id         = module.network.vpc_id  
  service_name   = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type
  private_dns_enabled = var.private_dns_enabled

  tags = {
    Name = "${var.environment}-${var.stack_name}-vpc-endpoint"
  }
}

# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = module.network.vpc_id
  peer_vpc_id   = var.peer_vpc_id
  peer_owner_id = var.peer_owner_id
  peer_region   = var.peer_region
  auto_accept   = false

  tags = {
    Side = "Requester"
    Name = "${var.environment}-${var.stack_name}-vpc-peering"
  }
}

# Associate VPC peering connection with route tables

resource "aws_route" "public_peering_route" {
  count = length(module.network.public_route_table_ids)

  route_table_id            = module.network.public_route_table_ids[count.index]
  destination_cidr_block    = var.peer_vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "private_peering_route" {
  count = length(module.network.private_route_table_ids)

  route_table_id            = module.network.private_route_table_ids[count.index]
  destination_cidr_block    = var.peer_vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

resource "aws_route" "database_peering_route" {
  count = length(module.network.database_route_table_ids)

  route_table_id            = module.network.database_route_table_ids[count.index]
  destination_cidr_block    = var.peer_vpc_cidr_range
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}
