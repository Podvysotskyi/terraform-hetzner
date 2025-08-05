variable "cloudflare" {
  description = "The Cloudflare configuration"
  type = object({
    email  = string
    token  = string
    domain = string
  })
}

variable "record" {
  description = "DNS record configuration"
  type        = object({
    name = string
    ip   = string
  })
}