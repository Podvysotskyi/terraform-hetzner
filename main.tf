terraform {
  backend "s3" {
    bucket   = "podvysotskyi-github"
    endpoint = "https://fsn1.your-objectstorage.com"
    key      = "terraform-hetzner/terraform.tfstate"

    region                      = "main" # this is required, but will be skipped!
    skip_credentials_validation = true   # this will skip AWS related validation
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}

module "mysql" {
  source = "./mysql"

  docker_host         = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  mysql_root_password = var.MYSQL_ROOT_PASSWORD
}

module "traefik" {
  source = "./traefik"

  docker_host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"

  hetzner_ip = var.HETZNER_IP

  cloudflare_token  = var.CLOUDFLARE_TOKEN
  cloudflare_email  = var.CLOUDFLARE_EMAIL
  cloudflare_domain = var.CLOUDFLARE_DOMAIN

  mysql_port = module.mysql.port
}
