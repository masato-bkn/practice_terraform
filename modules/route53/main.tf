data "aws_route53_zone" "sample_zone" {
  name = "fmt-sample-route53.work"
}

resource "aws_route53_record" "sample_record" {
  zone_id = data.aws_route53_zone.sample_zone.zone_id
  name    = ""
  type    = "A"
  alias {
    name                   = var.target_alb.dns_name
    zone_id                = var.target_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "validation" {
  depends_on = [var.target_acm]

  zone_id = data.aws_route53_zone.sample_zone.zone_id
  ttl     = 300
  name    = var.target_acm.domain_validation_options.0.resource_record_name
  type    = var.target_acm.domain_validation_options.0.resource_record_type
  records = [var.target_acm.domain_validation_options.0.resource_record_value]
}
