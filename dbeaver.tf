module "dbeaver" {
  source = "./modules/deployable/docker/dbeaver"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  server = {
    hostname = var.CLOUDFLARE_DOMAIN
  }

  networks = [
    module.mysql.network,
    module.postgres.network,
  ]
}

module "dbeaver_cloudflare_record" {
  source = "./modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.CLOUDFLARE_EMAIL
    token  = var.CLOUDFLARE_TOKEN
    domain = var.CLOUDFLARE_DOMAIN
  }

  record = {
    ip   = var.HETZNER_IP
    name = module.dbeaver.host
  }
}