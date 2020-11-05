resource "aws_alb" "sample_alb" {
  name            = "sample-alb"
  security_groups = var.security_groups
  subnets         = var.subnets
}

resource "aws_alb_target_group" "sample_alb_tg" {
  name     = "sample-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_target_group_attachment" "sample_alb" {
  target_group_arn = aws_alb_target_group.sample_alb_tg.arn
  target_id        = var.target_id
  port             = 80
}

resource "aws_lb_listener" "sample_alb_listener" {
  load_balancer_arn = aws_alb.sample_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.sample_alb_tg.arn
    type             = "forward"
  }
}
