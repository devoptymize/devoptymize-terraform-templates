module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  # Autoscaling group
  name = var.asg_name
  use_name_prefix = false
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  #wait_for_capacity_timeout = 0
  #health_check_type         = "EC2"
  vpc_zone_identifier       = var.subnet_id
  load_balancers = var.load_balancing_action == "Attach_Classic_Load_Balancer" ? var.load_balancer : []
  target_group_arns = var.load_balancing_action == "Attach_ALB_NLB" ? var.load_balancer : []
  

  create_launch_template = false
  launch_template = var.launch_template
   
}


resource "aws_autoscaling_notification" "example_notifications" {
   count = (length(regexall("null", "${var.sns_topic}"))) > 0 ? 0 : 1

  group_names = [
    module.asg.autoscaling_group_name
  ]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  #topic_arn = (length(regexall("null", "${var.sns_topic}"))) > 0 ? null : var.sns_topic
   topic_arn =  var.sns_topic
}

