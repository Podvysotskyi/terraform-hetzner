variable "CODER_POSTGRES_PASSWORD" {
  type = string
}

module "coder" {
  source = "./modules/deployable/docker/coder"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  server = {
    hostname = var.CLOUDFLARE_DOMAIN
  }

  postgres = {
    network  = module.postgres.network
    host     = module.postgres.host
    password = var.CODER_POSTGRES_PASSWORD
  }
}

module "coder_cloudflare_record" {
  source = "./modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.CLOUDFLARE_EMAIL
    token  = var.CLOUDFLARE_TOKEN
    domain = var.CLOUDFLARE_DOMAIN
  }

  record = {
    ip   = var.HETZNER_IP
    name = module.coder.host
  }
}