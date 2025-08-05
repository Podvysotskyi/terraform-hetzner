module "traefik" {
  source = "../modules/deployable/docker/traefik"

  docker = var.docker_host

  server = {
    hostname = var.cloudflare_domain
  }

  cloudflare = {
    email = var.cloudflare_email
    token = var.cloudflare_token
  }

  tcp_ports = [
    {
      port = var.mysql_port
    },
  ]
}

module "traefik_cloudflare_record" {
  source = "../modules/common/cloudflare/dns-record"

  cloudflare = {
    email  = var.cloudflare_email
    token  = var.cloudflare_token
    domain = var.cloudflare_domain
  }

  record = {
    ip   = var.hetzner_ip
    name = module.traefik.host
  }
}