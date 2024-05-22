output "private_ip" {
  value = aws_instance.private-ec2.private_ip
}

output "db_id"{
  value = aws_instance.private-ec2.id
}