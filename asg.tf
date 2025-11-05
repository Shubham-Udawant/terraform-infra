resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = aws_subnet.aws_jhooq_public_subnets[*].id

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  #target_group_arns = [aws_lb_target_group.web_tg.arn] # optional if using ALB

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
