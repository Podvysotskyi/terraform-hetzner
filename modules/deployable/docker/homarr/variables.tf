variable "docker" {
  description = "Docker Configuration"
  type        = object({
    host = string
    path = optional(string, "/home/docker")
  })
}

variable "server" {
  description = "Server Configuration"
  type        = object({
    host = string
  })
}

variable "traefik" {
  description = "Traefik Configuration"
  type        = object({
    host    = optional(string, null)
    network = optional(string, "traefik")
  })

  default = {}
}

variable "homarr" {
  description = "Homarr Configuration"
  type        = object({
    secret_key = string
  })
}