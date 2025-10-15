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
        source      = local.docker_path
        destination = "/var/run/docker.sock"
        read_only   = true
      },
      {
        source      = "${var.docker.path}/${local.container_name}/appdata"
        destination = "/appdata"
      },
    ]

    env = [
      "SECRET_ENCRYPTION_KEY=${var.homarr.secret_key}",
      "AUTH_PROVIDERS=oidc,credentials",
      "AUTH_OIDC_CLIENT_ID=${var.authentik.client_id}",
      "AUTH_OIDC_CLIENT_SECRET=${var.authentik.client_secret}",
      "AUTH_OIDC_ISSUER=https://${var.authentik.host}/application/o/${var.authentik.slug}/",
      "AUTH_OIDC_URI=https://${var.authentik.host}/application/o/authorize",
      "AUTH_OIDC_CLIENT_NAME=authentik",
      "OAUTH_ALLOW_DANGEROUS_EMAIL_ACCOUNT_LINKING=true",
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