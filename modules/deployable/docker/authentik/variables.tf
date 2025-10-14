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

variable "redis" {
  description = "Redis Configuration"
  type        = object({
    network = string
    host    = string
  })
}

variable "postgres" {
  description = "Postgres Configuration"
  type        = object({
    network  = string
    host     = string
    database = optional(string, "authentik")
    password = string
    user     = optional(string, "authentik")
  })
}

variable "authentik" {
  description = "Authentik Configuration"
  type        = object({
    secret_key = string
  })
}