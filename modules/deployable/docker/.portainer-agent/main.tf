locals {
  image          = "portainer/agent"
  image_version  = "2.21.5"
  container_name = "portainer-agent"
}

locals {
  port           = 9001
  docker_path    = "/var/run/docker.sock"
  docker_volumes = "/var/lib/docker/volumes"
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
        source      = local.docker_volumes
        destination = "/var/lib/docker/volumes"
      },
      {
        source      = "/"
        destination = "/host"
      },
    ]
  }

  traefik = {
    enable  = true
    network = var.traefik.network

    tcp = {
      port = local.port
    }
  }
}