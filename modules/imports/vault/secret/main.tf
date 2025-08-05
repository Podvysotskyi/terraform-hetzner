data "vault_generic_secret" "secret" {
  path = "secret/homelab/${var.path}"
}