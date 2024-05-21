resource "aws_lb" "paula-lb" {
  name               = var.lb_name
  internal           =  var.internal
  load_balancer_type =  var.load_balancer_type
  security_groups    = var.security_group_ids_LB
  subnets            = var.subnet_ids_LB

  enable_deletion_protection =  var.enable_deletion_protection
}
# ----------------------- ------------------------------------#
resource "aws_lb_target_group" "my_target_group" {
  # name     =  var.target_name
  port     =  var.port
  protocol =    var.protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP" 
    matcher             = "200"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.paula-lb.arn
  port              =  var.port
  protocol          =  var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

# resource "aws_lb_target_group_attachment" "wordpress_target_attachment" {
#   target_group_arn =  aws_lb_target_group.my_target_group.arn
#   target_id        =var.target_id 
#   port             = 80
# }