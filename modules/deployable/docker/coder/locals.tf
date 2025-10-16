locals {
  image          = "ghcr.io/coder/coder"
  image_version  = "v2.27.0"
  container_name = "coder"

  port = 7080

  docker_path = "/var/run/docker.sock"

  host = var.traefik.host != null ? var.traefik.host : "${local.container_name}.${var.server.hostname}"
}