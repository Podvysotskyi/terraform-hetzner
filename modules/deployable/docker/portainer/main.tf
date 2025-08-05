locals {
  image          = "portainer/portainer-ce"
  image_version  = "2.21.5"
  container_name = "portainer"
}

locals {
  port        = 9000
  docker_path = "/var/run/docker.sock"
  host        = var.traefik.host != null ? var.traefik.host : "${local.container_name}.${var.server.hostname}"
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
        source      = local.docker_path
        destination = "/var/run/docker.sock"
        read_only   = true
      },
      {
        source      = "${var.docker.path}/${local.container_name}/data"
        destination = "/data"
      },
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