resource "aws_launch_template" "template" {
  name   = var.name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    security_groups             = var.security_group_id
    associate_public_ip_address = var.associate_public_ip_address
    subnet_id                   = var.subnet_id
  }

  monitoring {
    enabled = var.monitoring
  }

  user_data = var.user_data
}

# Key Pair
# resource "aws_key_pair" "my_key_pair" {
#   key_name   = var.key_name
#   public_key = file("~/.ssh/id_rsa.pub") 
# }



