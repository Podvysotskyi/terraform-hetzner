variable "docker_host" {
  type      = string
  sensitive = true
}

variable "cloudflare_email" {
  type      = string
  sensitive = true
}

variable "cloudflare_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_domain" {
  type      = string
  sensitive = true
}

variable "hetzner_ip" {
  type      = string
  sensitive = true
}
