output "network" {
  value = module.network.name
}

output "host" {
  value = module.container.name
}

output "port" {
  value = local.port
}