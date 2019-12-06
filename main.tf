module.lb.locals {
  sg_id = concat(
    aws_security_group.alb_sg.*.id,
    [""],
  )[0]
}

resource "aws_alb" "alb" {
  count = var.create_alb ? 1 : 0
  load_balancer_type = "application"
  internal = var.alb_internal
  name = var.load_balancer_name
  security_groups = aws_security_group.alb_sg.*.id
  subnets = var.subnets
}

resource "aws_alb_target_group" "alb_target_group" {
  count = var.create_alb ? 1 : 0
  name = var.tg_name
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  stickiness {
    type = "lb_cookie"
  }
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_alb_listener" "alb_listener_http" {
  count = var.create_alb ? 1 : 0
  load_balancer_arn = aws_alb.alb[count.index].arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group[count.index].arn
    type = "forward"
  }
}

resource "aws_alb_target_group_attachment" "alb_tg_attachment" {
  count = var.create_alb ? 1 : 0
  target_group_arn = aws_alb_target_group.alb_target_group[count.index].arn
  target_id = var.target_id[count.index]
  port = 80
}

resource "aws_security_group" "alb_sg" {
  count  = var.create ? 1 : 0
  name   = var.name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "ingress_rule_http" {
  count             = var.create_ingress_rule ? 1 : 0
  security_group_id = local.sg_id
  type              = "ingress"
  cidr_blocks       = var.cidr_blocks
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
}

resource "aws_security_group_rule" "egress" {
  security_group_id = local.sg_id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
