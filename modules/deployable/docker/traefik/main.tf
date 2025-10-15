module "bridge-network" {
  source = "../../../imports/docker/network"
  docker = var.docker

  name = "bridge"
}

module "network" {
  source = "../../../common/docker/network"
  docker = var.docker

  network = {
    name     = local.network_name
    internal = true
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
      module.bridge-network.name,
      module.network.name,
    ]

    command = concat([
      "--api.insecure=true",
      "--providers.docker=true",
      "--providers.docker.exposedbydefault=false",
      "--providers.file.directory=/etc/traefik",
      "--entryPoints.web.address=:${var.http_port}",
      "--entryPoints.websecure.address=:${var.https_port}",
      "--certificatesresolvers.cloudflare.acme.email=${var.cloudflare.email}",
      "--certificatesresolvers.cloudflare.acme.dnschallenge.provider=cloudflare",
      "--certificatesresolvers.cloudflare.acme.storage=/letsencrypt/acme.json",
      "--serversTransport.insecureSkipVerify=true",
    ], [
      for tcp_port in var.tcp_ports : "--entryPoints.tcp${tcp_port.port}.address=:${tcp_port.port}/tcp"
    ], [
      for udp_port in var.udp_ports : "--entryPoints.udp${udp_port.port}.address=:${udp_port.port}/udp"
    ])

    labels = [
      {
        key   = "traefik.http.middlewares.https-redirect.redirectscheme.scheme"
        value = "https"
      },
      {
        key   = "traefik.http.middlewares.https-redirect.redirectscheme.permanent"
        value = "true"
      },
    ]

    env = [
      "CLOUDFLARE_DNS_API_TOKEN=${var.cloudflare.token}",
    ]

    ports = concat([
      {
        container = 80
        host      = var.http_port
      },
      {
        container = 443
        host      = var.https_port
      },
    ], [
      for tcp_port in var.tcp_ports: {
        container = tcp_port.port
        host      = tcp_port.target != null ? tcp_port.target : tcp_port.port
        protocol  = "tcp"
      }
    ], [
      for udp_port in var.udp_ports: {
        container = udp_port.port
        host      = udp_port.target != null ? udp_port.target : udp_port.port
        protocol  = "udp"
      }
    ])

    volumes = [
      {
        source      = local.docker_path
        destination = local.docker_path
        read_only   = true
      },
      {
        source      = "${var.docker.path}/${local.container_name}/letsencrypt"
        destination = "/letsencrypt"
      },
      {
        source      = "${var.docker.path}/${local.container_name}/config"
        destination = "/etc/traefik/"
      }
    ]
  }

  traefik = {
    enable  = true
    network = module.network.name

    http = {
      port = local.port
      host = local.host
    }
  }
}