resource "aws_acm_certificate" "sample_certificate" {
  domain_name = var.domain.name

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "sample_validation" {
  certificate_arn = aws_acm_certificate.sample_certificate.arn

  validation_record_fqdns = [var.aws_route53_record.fqdn]
}
