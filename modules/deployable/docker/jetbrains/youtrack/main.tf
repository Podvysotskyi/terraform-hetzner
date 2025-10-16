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
      var.traefik.network,
      module.network.name
    ]

    volumes = [
      {
        source      = "${var.docker.path}/jetbrains/youtrack/data"
        destination = "/opt/youtrack/data"
      },
      {
        source      = "${var.docker.path}/jetbrains/youtrack/conf"
        destination = "/opt/youtrack/conf"
      },
      {
        source      = "${var.docker.path}/jetbrains/youtrack/logs"
        destination = "/opt/youtrack/logs"
      },
      {
        source      = "${var.docker.path}/jetbrains/youtrack/backups"
        destination = "/opt/youtrack/backups"
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