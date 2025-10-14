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

    networks = var.traefik.enable == true ? [
      var.traefik.network,
      module.network.name,
    ] : [module.network.name]

    volumes = [
      {
        source      = "${var.docker.path}/${local.container_name}/data"
        destination = "/data"
      },
    ]
  }

  traefik = {
    enable  = var.traefik.enable
    network = var.traefik.network

    tcp = {
      port = local.port
    }
  }
}