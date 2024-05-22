resource "aws_instance" "public-ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  vpc_security_group_ids      = var.SG_id
  subnet_id                   = var.ec2_subnet_ID
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_pair
  # user_data                   = var.user_data
  tags = {
    Name = var.ec2_name
  }

#  provisioner "local-exec" {
#   command = <<EOT
#     ansible-playbook -e /home/paula/terraform_mysql_wordpress/terraform_mysql_wordpress/modules/VMS/ansible/override_vars.yml -i /home/paula/terraform_mysql_wordpress/terraform_mysql_wordpress/modules/VMS/ansible/demo.aws_ec2.yml /home/paula/terraform_mysql_wordpress/terraform_mysql_wordpress/modules/VMS/ansible/wordpress.yaml
#   EOT
# }

}
