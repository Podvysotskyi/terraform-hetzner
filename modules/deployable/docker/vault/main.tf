locals {
  image          = "hashicorp/vault"
  image_version  = "1.19"
  container_name = "vault"
}

locals {
  port = 8080
  host = var.traefik.host != null ? var.traefik.host : "${local.container_name}-${var.server.hostname}"
}

module "network" {
  source = "../../../common/docker/network"
  docker = var.docker

  network = {
    name = local.container_name
  }
}

module "container" {
  source = "../../../common/docker/container"
  docker = var.docker

  container = {
    name    = local.container_name
    image   = local.image
    version = local.image_version

    networks = [
      module.network.name,
      var.traefik.network,
    ]

    volumes = [
      {
        source      = "${var.docker.path}/${local.container_name}/logs"
        destination = "/vault/logs"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/config"
        destination = "/vault/config"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/data"
        destination = "/vault/data"
      }
    ]

    env = [
      "VAULT_LOCAL_CONFIG={\"storage\": {\"file\": {\"path\": \"/vault/data\"}}, \"default_lease_ttl\": \"168h\", \"max_lease_ttl\": \"720h\", \"ui\": true, \"disable_mlock\": true}"
    ]
  }

  traefik = {
    enable  = true
    network = var.traefik.network

    http = {
      host   = local.host
      scheme = "https"
      port   = 8200
    }
  }
}