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

    env = [
      "AUTHENTIK_POSTGRESQL__HOST=${var.postgres.host}",
      "AUTHENTIK_POSTGRESQL__NAME=${var.postgres.database}",
      "AUTHENTIK_POSTGRESQL__PASSWORD=${var.postgres.password}",
      "AUTHENTIK_POSTGRESQL__USER=${var.postgres.user}",
      "AUTHENTIK_REDIS__HOST=${var.redis.host}",
      "AUTHENTIK_SECRET_KEY=${var.authentik.secret_key}",
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
        source      = local.docker_path
        destination = "/var/run/docker.sock"
        read_only   = true
      },
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

    env = [
      "AUTHENTIK_POSTGRESQL__HOST=${var.postgres.host}",
      "AUTHENTIK_POSTGRESQL__NAME=${var.postgres.database}",
      "AUTHENTIK_POSTGRESQL__PASSWORD=${var.postgres.password}",
      "AUTHENTIK_POSTGRESQL__USER=${var.postgres.user}",
      "AUTHENTIK_REDIS__HOST=${var.redis.host}",
      "AUTHENTIK_SECRET_KEY=${var.authentik.secret_key}",
    ]

    command = ["worker"]
  }
}