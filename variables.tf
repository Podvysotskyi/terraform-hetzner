// Hetzner

variable "HETZNER_IP" {
  type = string
  sensitive = true
}

variable "HETZNER_USER" {
  type = string
  sensitive = true
}

variable "HETZNER_PASSWORD" {
  type      = string
  sensitive = true
}

variable "HETZNER_SSH_PORT" {
  type    = number
  default = 22
}

// Cloudflare

variable "CLOUDFLARE_EMAIL" {
  type = string
}

variable "CLOUDFLARE_TOKEN" {
  type      = string
  sensitive = true
}

variable "CLOUDFLARE_DOMAIN" {
  type = string
}

// MySQL

variable "MYSQL_ROOT_PASSWORD" {
  type      = string
  sensitive = true
}
