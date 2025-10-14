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
    network = optional(string, "redis")
  })
  default     = {}
}

variable "postgres" {
  description = "Postgres Configuration"
  type        = object({
    network = optional(string, "postgresql")
  })
  default     = {}
}
