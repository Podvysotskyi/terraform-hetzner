module "jetbrains_youtrack" {
  source = "./modules/deployable/docker/jetbrains/youtrack"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  traefik = {
    host = "youtrack.jetbrains.${var.CLOUDFLARE_DOMAIN}"
  }
}

module "jetbrains_teamcity_server" {
  source = "./modules/deployable/docker/jetbrains/teamcity-server"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  traefik = {
    host = "teamcity.jetbrains.${var.CLOUDFLARE_DOMAIN}"
  }

  networks = [
    module.jetbrains_youtrack.network,
    module.postgres.network
  ]
}

module "jetbrains_teamcity_server_cloudflare_record" {
  source = "./modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.CLOUDFLARE_EMAIL
    token  = var.CLOUDFLARE_TOKEN
    domain = var.CLOUDFLARE_DOMAIN
  }

  record = {
    ip   = var.HETZNER_IP
    name = module.jetbrains_teamcity_server.host
  }
}

module "jetbrains_youtrack_cloudflare_record" {
  source = "./modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.CLOUDFLARE_EMAIL
    token  = var.CLOUDFLARE_TOKEN
    domain = var.CLOUDFLARE_DOMAIN
  }

  record = {
    ip   = var.HETZNER_IP
    name = module.jetbrains_youtrack.host
  }
}