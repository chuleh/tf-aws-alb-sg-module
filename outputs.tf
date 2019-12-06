output "alb_sg" {
  description = "sg of the ALB"
  value = aws_security_group.alb_sg.*.id
}
