variable "AUTHENTIK_POSTGRES_PASSWORD" {
  type      = string
  sensitive = true
}

variable "AUTHENTIK_SECRET_KEY" {
  type      = string
  sensitive = true
}

module "authentik" {
  source = "./modules/deployable/docker/authentik"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  server = {
    hostname = var.CLOUDFLARE_DOMAIN
  }

  authentik = {
    secret_key = var.AUTHENTIK_SECRET_KEY
  }

  postgres = {
    network  = module.postgres.network
    host     = module.postgres.host
    password = var.AUTHENTIK_POSTGRES_PASSWORD
  }

  redis = {
    network = module.redis.network
    host    = module.redis.host
  }
}

module "authentik_cloudflare_record" {
  source = "./modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.CLOUDFLARE_EMAIL
    token  = var.CLOUDFLARE_TOKEN
    domain = var.CLOUDFLARE_DOMAIN
  }

  record = {
    ip   = var.HETZNER_IP
    name = module.authentik.host
  }
}
