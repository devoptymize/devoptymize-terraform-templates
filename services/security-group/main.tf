resource "aws_security_group" "sg" {
 vpc_id = var.vpc_id
 name = var.security_group_name
 description = var.description
 ingress = local.ingress_rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
    ingress_rule = [ for v in var.ingress_rules : {  from_port = v[0], to_port = v[0] , protocol = v[1], cidr_blocks = v[2] ,security_groups = v[3] , description = "", ipv6_cidr_blocks = [], prefix_list_ids = [], self= false} ]

}
