resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  target_type = var.target_type
  port = var.target_type == "instance" || var.target_type == "ip" || var.target_type == "alb" ? var.port_number : null
  protocol = var.target_type == "instance" || var.target_type == "ip" || var.target_type == "alb" ? var.protocol_type : null
  vpc_id = var.target_type == "instance" || var.target_type == "ip" || var.target_type == "alb" ? var.vpc_id : null
}

resource "aws_lb_target_group_attachment" "ec2target" {
  count            = var.ec2_id != [] ? length(var.ec2_id) : 0
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.ec2_id[count.index]
  port = var.port_number
}

resource "aws_lb_target_group_attachment" "iptarget" {
  count            = var.ip_address != [] ? length(var.ip_address) : 0
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.ip_address[count.index]
  port = var.port_number
}

resource "aws_lb_target_group_attachment" "albtarget" {
  count            = var.application_load_balancer != "" ? 1 : 0
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.application_load_balancer
  port = var.port_number
}

resource "aws_lb_target_group_attachment" "lambdatarget" {
  count            = var.lambda_function_name != "" ? 1 : 0
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.lambda_function_arn 
  port       = null
  depends_on = [aws_lambda_permission.with_lb]
}

resource "aws_lambda_permission" "with_lb" {
  count         = var.lambda_function_name != "" ? 1 : 0
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.target_group.arn
}
