module "container" {
  source = "../../../../common/docker/container"
  docker = var.docker

  container = {
    name    = local.container_name
    image   = local.image
    version = local.image_version

    networks = concat([
      var.traefik.network,
    ], var.networks)

    volumes = [
      {
        source      = "${var.docker.path}/jetbrains/teamcity-server/data"
        destination = "/data/teamcity_server/datadir"
      },
      {
        source      = "${var.docker.path}/jetbrains/teamcity-server/logs"
        destination = "/opt/teamcity/logs"
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