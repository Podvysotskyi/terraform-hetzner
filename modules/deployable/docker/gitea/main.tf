locals {
  image          = "docker.gitea.com/gitea"
  image_version  = "1.23.5"
  container_name = "gitea"
}

locals {
  http_port = 3000
  ssh_port  = 22
  host      = var.traefik.host != null ? var.traefik.host : "${local.container_name}-${var.server.hostname}"
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
        source      = "/etc/timezone"
        destination = "/etc/timezone"
        read_only   = true
      },
      {
        source      = "/etc/localtime"
        destination = "/etc/localtime"
        read_only   = true
      },
      {
        source      = "${var.docker.path}/${local.container_name}/data"
        destination = "/data"
      },
    ]

    env = [
      # "USER_UID=1000",
      # "USER_GID=1000",
      "GITEA__database__DB_TYPE=${var.database.type}",
      "GITEA__database__HOST=${var.database.host}:${var.database.port}",
      "GITEA__database__NAME=${var.database.database}",
      "GITEA__database__USER=${var.database.user}",
      "GITEA__database__PASSWD=${var.database.password}",
    ]
  }

  traefik = {
    enable  = true
    network = var.traefik.network

    http = {
      host = local.host
      port = local.http_port
    }

    tcp = {
      port = local.ssh_port
    }
  }
}