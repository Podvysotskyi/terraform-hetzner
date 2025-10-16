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
    hostname = string
  })
}

variable "traefik" {
  description = "Traefik Configuration"
  type        = object({
    host    = optional(string, null)
    network = optional(string, "traefik")
  })
  default     = {}
}

variable "postgres" {
  description = "Docker networks"
  type        = object({
    network  = optional(string, "postgresql")
    host     = optional(string, "postgresql")
    username = optional(string, "coder")
    password = string
    database = optional(string, "coder")
  })
}

variable "authentik" {
  description = "Authentik Configuration"
  type        = object({
    host          = string
    domain        = string
    client_id     = string
    client_secret = string
  })
}