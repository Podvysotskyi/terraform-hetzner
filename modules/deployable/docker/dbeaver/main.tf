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

    networks = concat([
      module.network.name,
      var.traefik.network,
    ], var.networks)

    volumes = [
      {
        source      = "${var.docker.path}/${local.container_name}/workspace"
        destination = "/opt/cloudbeaver/workspace"
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