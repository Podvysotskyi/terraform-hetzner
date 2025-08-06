variable "MYSQL_ROOT_PASSWORD" {
  type      = string
  sensitive = true
}

module "mysql" {
  source = "./modules/deployable/docker/mysql"

  docker = {
    host = "ssh://${var.HETZNER_USER}@${var.HETZNER_IP}:${var.HETZNER_SSH_PORT}"
  }

  mysql = {
    password = var.MYSQL_ROOT_PASSWORD
  }
}