locals {
  image          = "dbeaver/cloudbeaver"
  image_version  = "25.2"
  container_name = "dbeaver"

  port = 8978

  host = var.traefik.host != null ? var.traefik.host : "${local.container_name}.${var.server.hostname}"
}