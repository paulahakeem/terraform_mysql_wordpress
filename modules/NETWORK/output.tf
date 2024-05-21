output "public_subnet_id1" {
  value = aws_subnet.subnet["public_subnet1"].id
}

output "public_subnet_id2" {
  value = aws_subnet.subnet["public_subnet2"].id
}


output "private_subnet_id1" {
  value = aws_subnet.subnet["private_subnet_1"].id
}


output "secgroup-id" {
value = aws_security_group.secgroup.id    
}



output "vpc_id" {
  value       = aws_vpc.mainvpc.id
}