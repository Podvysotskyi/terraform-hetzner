locals {
  image          = "adguard/adguardhome"
  image_version  = "v0.107.59"
  container_name = "adguardhome"
}

locals {
  http_port = 3000
  dns_port  = 53
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
        source      = "${var.docker.path}/${local.container_name}/work"
        destination = "/opt/adguardhome/work"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/conf"
        destination = "/opt/adguardhome/conf"
      },
    ]

    ports = [
      {
        container = local.dns_port
        host      = local.dns_port
        protocol  = "tcp"
      },
      {
        container = local.dns_port
        host      = local.dns_port
        protocol  = "udp"
      },
    ]
  }

  traefik = {
    enable  = true
    network = var.traefik.network

    http = {
      host = local.host
      port = local.http_port
    }
  }
}