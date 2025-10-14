locals {
  image          = "ghcr.io/goauthentik/server"
  image_version  = "2025.8.4"
  container_name = "authentik"

  port = 9000

  host = var.traefik.host != null ? var.traefik.host : "${local.container_name}.${var.server.hostname}"
}