output "web_sg" {
  value = aws_security_group.web-sg
}

output "alb_sg" {
  value = aws_security_group.alb-sg
}

output "db_sg" {
  value = aws_security_group.db-sg
}
