resource "aws_route53_zone" "orangenetwork" {
  name = "orangenetwork.local"
}


resource "aws_route53_record" "learn_prac-ed_orangenetwork_local" {
  allow_overwrite = false
  name            = "learn.prac-ed.orangenetwork.local"
  type            = "A"
  zone_id         = aws_route53_zone.orangenetwork.id

  alias {
    name                   = aws_lb.k3s-server-lb.dns_name
    zone_id                = "ZCT6FZBF4DROD"
    evaluate_target_health = false
  }
  # depends_on = [time_sleep.wait_90_seconds]
}

# resource "time_sleep" "wait_50_seconds" {
#   create_duration = "50s"
# }
    
# resource "aws_route53_record" "learn_prac-ed_orangenetwork_local_cname" {
#   zone_id = aws_route53_zone.orangenetwork.id
#   name    = "learn.prac-ed.orangenetwork.local"
#   type    = "CNAME"
#   ttl     = "60"
#   records = [aws_lb.k3s-server-lb.dns_name]
  
#   depends_on = [time_sleep.wait_50_seconds]
# }

########### ONLY FOR REFERENCE ########### 

# resource "aws_route53_record" "gloo-ping" {
#   zone_id = data.aws_route53_zone.hosted-zone-id.id
#   name    = replace(var.monitor_url, "/^.*:[/][/]/", "")
#   type    = "CNAME"
#   ttl     = "60"

#   records        = [var.gloo_nlb]
# }

# locals {
#   domain_list = split(".", "https://gloo-ping.us-west-2.paas-uat.global.xero-uat.com")
#   zone_list = reverse(slice(reverse(local.domain_list), 0, 3))
#   hostedzone = join(".", local.zone_list)
# }



