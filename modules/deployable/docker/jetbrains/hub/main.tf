module "network" {
  source = "../../../../common/docker/network"
  docker = var.docker

  network = {
    name = local.container_name
  }
}

module "container" {
  source = "../../../../common/docker/container"
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
        source      = "${var.docker.path}/jetbrains/hub/data"
        destination = "/opt/hub/data"
      },
      {
        source      = "${var.docker.path}/jetbrains/hub/conf"
        destination = "/opt/hub/conf"
      },
      {
        source      = "${var.docker.path}/jetbrains/hub/logs"
        destination = "/opt/hub/logs"
      },
      {
        source      = "${var.docker.path}/jetbrains/hub/backups"
        destination = "/opt/hub/backups"
      },
    ]
  }

  traefik = {
    enable  = true
    network = var.traefik.network

    http = {
      host = var.traefik.host
      port = local.port
    }
  }
}