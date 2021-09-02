resource "aws_alb_target_group" "default" {
  name_prefix          = substr(local.instance_name, 0, 6)
  port                 = local.app_port
  protocol             = "HTTP"
  vpc_id               = local.vpc_id
  deregistration_delay = "0"
  target_type          = "instance"

  stickiness {
    type            = "lb_cookie"
    enabled         = "false"
  }

  health_check {
    interval            = "10"
    path                = "/about"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    matcher             = "200-304"
  }

  lifecycle {
    create_before_destroy = true
  }
}
