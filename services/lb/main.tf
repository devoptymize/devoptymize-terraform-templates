module "lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = var.loadbalancer_name

  load_balancer_type = var.loadbalancer_type == "Application_Load_Balancer" ? "application" : "network"

  vpc_id             = var.vpc_id
  subnets            = var.subnet_id
  security_groups    = var.security_group_id 
  internal = var.scheme == "internal" ? true : false
  ip_address_type = var.ip_address_type     
}

resource "aws_alb_listener" "loadbalancer" {
  load_balancer_arn = module.lb.lb_arn
  port = var.port
  protocol = var.protocol
  ssl_policy        = var.protocol == "HTTPS" || var.protocol == "TLS" ? var.security_policy : null
  certificate_arn   = var.protocol == "HTTPS" || var.protocol == "TLS" ? var.certificate_list : null
  default_action {
    target_group_arn = var.target_group_arn
    type             = "forward"
  }
}

