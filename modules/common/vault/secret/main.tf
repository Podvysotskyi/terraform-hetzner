resource "vault_generic_secret" "secret" {
  path      = "secret/homelab/${var.path}"
  data_json = jsonencode(var.data)
}