variable "HOMARR_SECRET_KEY" {
  type      = string
  sensitive = true
}

module "homarr" {
  source = "./modules/deployable/docker/homarr"

  traefik = {
    host = "dashboard.${var.CLOUDFLARE_DOMAIN}"
  }

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  server = {
    host = var.CLOUDFLARE_DOMAIN
  }

  homarr = {
    secret_key = var.HOMARR_SECRET_KEY
  }
}

module "homarr_cloudflare_record" {
  source = "./modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.CLOUDFLARE_EMAIL
    token  = var.CLOUDFLARE_TOKEN
    domain = var.CLOUDFLARE_DOMAIN
  }

  record = {
    ip   = var.HETZNER_IP
    name = module.homarr.host
  }
}