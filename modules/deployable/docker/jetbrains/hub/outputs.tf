output "network" {
  value = module.network.name
}

output "host" {
  value = var.traefik.host
}