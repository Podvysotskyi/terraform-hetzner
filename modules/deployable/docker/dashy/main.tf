locals {
  image          = "lissy93/dashy"
  image_version  = "3.1.0"
  container_name = "dashy"
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
        source      = "${var.docker.path}/${local.container_name}/config"
        destination = "/app/user-data"
      },
    ]

    env = [
      "NODE_ENV=production",
    ]
  }

  traefik = {
    enable  = true
    network = var.traefik.network

    http = {
      host = local.host
      port = local.port
    }
  }
}