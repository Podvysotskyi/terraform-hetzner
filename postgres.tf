variable "POSTGRES_USER" {
  type      = string
  sensitive = true
  default   = "postgres"
}

variable "POSTGRES_PASSWORD" {
  type      = string
  sensitive = true
}

variable "POSTGRES_DATABASE" {
  type      = string
  sensitive = true
  default   = "postgres"
}

module "postgres" {
  source = "./modules/deployable/docker/postgres"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  postgres = {
    user     = var.POSTGRES_USER
    password = var.POSTGRES_PASSWORD
    database = var.POSTGRES_DATABASE
  }
}