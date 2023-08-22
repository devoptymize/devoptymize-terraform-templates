module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = var.key_pair_name
  create_private_key = true
}

resource "local_file" "ssh_key" {
  filename = "${var.key_pair_name}.pem"
  content = module.key_pair.private_key_pem
}
