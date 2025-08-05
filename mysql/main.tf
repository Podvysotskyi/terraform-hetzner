module "mysql" {
  source = "../modules/deployable/docker/mysql"

  docker = {
    host = var.docker_host
  }

  mysql = {
    password = var.mysql_root_password
  }
}