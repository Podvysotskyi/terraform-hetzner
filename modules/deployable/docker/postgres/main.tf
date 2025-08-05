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
      var.traefik.network,
      module.network.name,
    ]

    volumes = [
      {
        source      = "${var.docker.path}/${local.container_name}/data"
        destination = "/var/lib/postgresql/data"
      },
    ]

    env = [
      "POSTGRES_USER=${var.postgres.user}",
      "POSTGRES_PASSWORD=${var.postgres.password}",
      "POSTGRES_DB=${var.postgres.database}",
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