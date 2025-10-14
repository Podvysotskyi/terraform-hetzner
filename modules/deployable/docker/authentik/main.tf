module "network" {
  source = "../../../common/docker/network"
  docker = var.docker

  network = {
    name = local.container_name
  }
}

module "server" {
  source = "../../../common/docker/container"
  docker = var.docker

  container = {
    name    = "${local.container_name}-server"
    image   = local.image
    version = local.image_version

    networks = [
      module.network.name,
      var.traefik.network,
      var.postgres.network,
      var.redis.network,
    ]

    volumes = [
      {
        source      = "${var.docker.path}/${local.container_name}/media"
        destination = "/media"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/templates"
        destination = "/templates"
      },
    ]

    command = ["server"]
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

module "worker" {
  source = "../../../common/docker/container"
  docker = var.docker

  container = {
    name    = "${local.container_name}-worker"
    image   = local.image
    version = local.image_version

    networks = [
      module.network.name,
      var.postgres.network,
      var.redis.network,
    ]

    volumes = [
      {
        source      = "${var.docker.path}/${local.container_name}/certs"
        destination = "/certs"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/media"
        destination = "/media"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/templates"
        destination = "/templates"
      },
    ]

    command = ["worker"]
  }
}