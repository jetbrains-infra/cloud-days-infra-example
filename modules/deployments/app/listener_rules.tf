resource "aws_alb_listener_rule" "default" {
  action {
    target_group_arn = aws_alb_target_group.default.arn
    type             = "forward"
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

  listener_arn = local.alb_listener_arn
}
