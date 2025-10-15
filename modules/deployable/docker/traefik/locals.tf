locals {
  image          = "traefik"
  image_version  = "v3.3"
  container_name = "traefik"
  network_name   = "traefik"

  port = 8080

  docker_path = "/var/run/docker.sock"

  host = "${local.container_name}.${var.server.hostname}"
}