resource "docker_network" "network" {
  name = var.network.name

  attachable      = true
  check_duplicate = true

  internal = var.network.internal
}
