output "lb_arn" {
  value = aws_lb.paula-lb.arn
}

output "lb_dns_name" {
  value = aws_lb.paula-lb.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.my_target_group.arn
}

output "lb_id" {
  value = aws_lb.paula-lb.id
}