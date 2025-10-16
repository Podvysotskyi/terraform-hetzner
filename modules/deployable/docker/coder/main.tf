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

    privileged = true

    networks = [
      module.network.name,
      var.traefik.network,
      var.postgres.network
    ]

    volumes = [
      {
        source      = local.docker_path
        destination = "/var/run/docker.sock"
        read_only   = true
      },
      {
        source      = "${var.docker.path}/${local.container_name}/home"
        destination = "/home/coder"
      },
    ]

    env = [
      "CODER_PG_CONNECTION_URL=postgresql://${var.postgres.username}:${var.postgres.password}@${var.postgres.host}/${var.postgres.database}?sslmode=disable",
      "CODER_HTTP_ADDRESS=0.0.0.0:7080",
      "CODER_ACCESS_URL=https://${local.host}",
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