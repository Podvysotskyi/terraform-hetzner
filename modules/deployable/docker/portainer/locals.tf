locals {
  image          = "portainer/portainer-ce"
  image_version  = "2.21.5"
  container_name = "portainer"

  port = 9000

  docker_path = "/var/run/docker.sock"

  host = var.traefik.host != null ? var.traefik.host : "${local.container_name}.${var.server.hostname}"
}