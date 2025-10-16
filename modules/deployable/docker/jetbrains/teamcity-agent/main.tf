module "container" {
  source = "../../../../common/docker/container"
  docker = var.docker

  container = {
    name    = local.container_name
    image   = local.image
    version = local.image_version

    privileged = true

    networks = [
      var.teamcity.network
    ]

    volumes = [
      {
        source      = "${var.docker.path}/jetbrains/teamcity-agent/conf"
        destination = "/data/teamcity_agent/conf"
      },
      {
        source      = "${var.docker.path}/jetbrains/teamcity-agent/work"
        destination = "/opt/buildagent/work"
      },
      {
        source      = "${var.docker.path}/jetbrains/teamcity-agent/system"
        destination = "/opt/buildagent/system"
      },
    ]

    env = [
      "SERVER_URL=https://${var.teamcity.host}",
      "DOCKER_IN_DOCKER=start",
    ]
  }

  traefik = {
    enable = false
  }
}