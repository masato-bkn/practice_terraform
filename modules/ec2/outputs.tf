output "sample-ec2" {
  value = aws_instance.web
}
output "eip" {
  value = aws_eip.web_eip
}
