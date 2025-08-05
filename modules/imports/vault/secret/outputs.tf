output "data" {
  value = data.vault_generic_secret.secret.data
}

output "data_json" {
  value = data.vault_generic_secret.secret.data_json
}