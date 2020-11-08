output "domain" {
  value = data.aws_route53_zone.sample_zone
}

output "aws_route53_record" {
  value = aws_route53_record.validation
}
