module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.instance_name
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = var.security_group_id
  subnet_id              = var.subnet_id
  
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = var.root_volume_size
    },
  ]
  
  tags = {
    Terraform   = "true"
    Environment = "${var.environment}"
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  count             = "${length(var.additional_volume_size)}"
  availability_zone = data.aws_subnet.selected.availability_zone
  size              = var.additional_volume_size[count.index]
  type              = "gp3"
  encrypted         = true
  tags = {
    Attached_to_Instance = "${var.instance_name}"
  }
  
}

resource "aws_volume_attachment" "volume_attachement" {
  count       = "${length(var.additional_volume_size)}"
  volume_id   = element(aws_ebs_volume.ebs_volume.*.id, count.index)
  device_name = (length(regexall("Linux", "${data.aws_ami.example.platform_details}")) > 0 ? var.linux_device_name[count.index] : var.win_device_name[count.index])
  instance_id = element(module.ec2.*.id, floor(count.index))
  force_detach = true
}
