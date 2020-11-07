resource "aws_route53_zone" "sample_zone" {
  name = "fmt-sample-route53.work"
}

resource "aws_route53_record" "sample_record" {
  zone_id = aws_route53_zone.sample_zone.zone_id
  name    = ""
  type    = "A"
  alias {
    name                   = var.target_alb.dns_name
    zone_id                = var.target_alb.zone_id
    evaluate_target_health = true
  }
}
