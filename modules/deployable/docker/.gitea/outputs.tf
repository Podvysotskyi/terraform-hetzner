output "network" {
  value = module.network.name
}

output "host" {
  value = local.host
}

output "port" {
  value = local.ssh_port   
}