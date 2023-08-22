resource "aws_launch_template" "launch_template" {
  name = var.launch_template_name
  
  dynamic "block_device_mappings" {
    for_each = [for k, volume in var.volume_size: {
      device_name = (length(regexall("Linux", "${data.aws_ami.example.platform_details}")) > 0 ? var.linux_device_name[k] : var.win_device_name[k])
      delete_on_termination =  false
      encrypted =  false
      volume_size = volume
      volume_type =  "gp2"
    }]
    content {
      device_name = block_device_mappings.value.device_name
      ebs {
        delete_on_termination = block_device_mappings.value.delete_on_termination
        encrypted = block_device_mappings.value.encrypted
        volume_size = block_device_mappings.value.volume_size
        volume_type = block_device_mappings.value.volume_type
      }
    }
  }


  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = false

  iam_instance_profile {
    name = (length(regexall("null", "${var.iam_instance_profile}"))) > 0 ? null : var.iam_instance_profile
  }

  image_id = (length(regexall("null", "${var.ami_id}"))) > 0 ? null : var.ami_id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = (length(regexall("null", "${var.instance_type}"))) > 0 ? null : var.instance_type

  key_name = (length(regexall("null", "${var.key_pair}"))) > 0 ? null : var.key_pair

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  update_default_version = true
  monitoring {
    enabled = true
  }

  vpc_security_group_ids = var.security_group_id
  user_data = "${base64encode(var.user_data)}"

}

