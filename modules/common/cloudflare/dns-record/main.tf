data "cloudflare_zone" "zone" {
  name = var.cloudflare.domain
}

resource "cloudflare_record" "record" {
  zone_id = data.cloudflare_zone.zone.zone_id
  name    = var.record.name
  content = var.record.ip
  type    = "A"
  proxied = false
  ttl     = 60
}
