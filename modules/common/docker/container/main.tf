resource "docker_image" "image" {
  name = "${var.container.image}:${var.container.version}"
}

locals {
  traefik_labels = var.traefik.enable == true ? [
    {
      key   = "traefik.enable"
      value = "true"
    },
    {
      key   = "traefik.docker.network"
      value = var.traefik.network
    },
  ] : []
  http_labels = var.traefik.http != null ? [
    # WEB
    {
      key   = "traefik.http.routers.${var.container.name}-web.entrypoints"
      value = "web"
    },
    {
      key   = "traefik.http.routers.${var.container.name}-web.rule"
      value = "Host(`${var.traefik.http.host}`)"
    },
    {
      key   = "traefik.http.routers.${var.container.name}-web.service"
      value = "${var.container.name}-web"
    },
    {
      key   = "traefik.http.services.${var.container.name}-web.loadbalancer.server.port"
      value = "${var.traefik.http.port}"
    },
    {
      key   = "traefik.http.services.${var.container.name}-web.loadbalancer.server.scheme"
      value = "${var.traefik.http.scheme}"
    },
    {
      key   = "traefik.http.services.${var.container.name}-web.loadbalancer.passhostheader"
      value = "true"
    },
    {
      key   = "traefik.http.routers.${var.container.name}-web.middlewares"
      value = "https-redirect"
    },
    # WEBSECURE
    {
      key   = "traefik.http.routers.${var.container.name}-websecure.entrypoints"
      value = "websecure"
    },
    {
      key   = "traefik.http.routers.${var.container.name}-websecure.rule"
      value = "Host(`${var.traefik.http.host}`)"
    },
    {
      key   = "traefik.http.routers.${var.container.name}-websecure.tls.certResolver"
      value = var.traefik.http.certresolver
    },
    {
      key   = "traefik.http.routers.${var.container.name}-websecure.service"
      value = "${var.container.name}-web"
    },
  ] : []
  tcp_labels = var.traefik.tcp != null ? [
    {
      key   = "traefik.tcp.routers.${var.container.name}-tcp.entrypoints"
      value = "tcp${var.traefik.tcp.port}"
    },
    {
      key   = "traefik.tcp.routers.${var.container.name}-tcp.rule"
      value = "HostSNI(`${var.traefik.tcp.host}`)"
    },
    {
      key   = "traefik.tcp.routers.${var.container.name}-tcp.service"
      value = "${var.container.name}-tcp"
    },
    {
      key   = "traefik.tcp.services.${var.container.name}-tcp.loadbalancer.server.port"
      value = "${var.traefik.tcp.port}"
    },
  ] : []
  udp_lables = var.traefik.udp != null ? [
    {
      key   = "traefik.udp.routers.${var.container.name}-udp.entrypoints"
      value = "udp${var.traefik.udp.port}"
    },
    {
      key   = "traefik.udp.routers.${var.container.name}-udp.service"
      value = "${var.container.name}-udp"
    },
    {
      key   = "traefik.udp.services.${var.container.name}-udp.loadbalancer.server.port"
      value = "${var.traefik.udp.port}"
    },
  ] : []
}

resource "docker_container" "container" {
  image    = docker_image.image.image_id
  name     = var.container.name
  hostname = var.container.name
  must_run = true
  restart  = "unless-stopped"
  command  = length(var.container.command) > 0 ? var.container.command : null

  cpu_shares        = 0
  ipc_mode          = "private"
  log_driver        = "json-file"
  max_retry_count   = 0
  memory            = 0
  memory_swap       = 0
  network_mode      = "bridge"
  privileged        = false
  publish_all_ports = false

  dynamic "ports" {
    for_each = var.container.ports
    content {
      internal = ports.value.container
      external = ports.value.host
      protocol = ports.value.protocol
    }
  }

  dynamic "volumes" {
    for_each = var.container.volumes
    content {
      container_path = volumes.value.destination
      host_path      = volumes.value.source
      read_only      = volumes.value.read_only
    } 
  }

  dynamic "networks_advanced" {
    for_each = var.container.networks
    content {
      name = networks_advanced.value
    }
  }

  dynamic "labels" {
    for_each = [for label in concat(var.container.labels, local.traefik_labels, local.http_labels, local.tcp_labels, local.udp_lables) : label]
    content {
      label = labels.value.key
      value = labels.value.value
    }
  }

  env = length(var.container.env) > 0 ? var.container.env : null
}