resource "aws_instance" "private-ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  vpc_security_group_ids      = var.SG_id
  subnet_id                   = var.ec2_subnet_ID
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_pair
  user_data                   = var.user_data
  tags = {
    Name = var.ec2_name
  }
    provisioner "local-exec" {
    command = "echo '${aws_instance.private-ec2.private_ip}' > instance_ip.txt"
  # }
  #     lifecycle {
  #   prevent_destroy = true
  }
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_pair
  public_key = file("~/.ssh/id_rsa.pub") 
}



# resource "aws_instance" "example" {
#   # existing configuration...

#   provisioner "local-exec" {
#     command = "ansible-playbook -i '${aws_instance.example[*].public_ip},' wordpress.yml"
#   }
# }
