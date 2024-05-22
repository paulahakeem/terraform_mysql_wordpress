resource "aws_autoscaling_group" "wordpress_asg" {
  name                      = var.name
  health_check_grace_period       = var.health_check_grace_period
  health_check_type               = var.health_check_type
  force_delete                    = var.force_delete
  vpc_zone_identifier             = var.vpc_zone_identifier
  desired_capacity                = var.desired_capacity
  max_size                        = var.max_size
  min_size                        = var.min_size

  tag {
    key                 = "Name"
    value               = var.ec2_instance_name
    propagate_at_launch = true
  }

  launch_template {
    id      = var.launch_template_id
    version = var.versions
  }
}

resource "aws_autoscaling_policy" "cpu_policy" {
  name                   = "cpu_policy"

  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.cpu_policy_percentage
  }
}


resource "aws_autoscaling_attachment" "application_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.name
  lb_target_group_arn    = var.alb_target_group_arn
}