locals {
  image          = "ghcr.io/homarr-labs/homarr"
  image_version  = "v1.41.0"
  container_name = "homarr"

  port = 7575

  docker_path = "/var/run/docker.sock"

  host = var.traefik.host != null ? var.traefik.host : "${local.container_name}.${var.server.host}"
}