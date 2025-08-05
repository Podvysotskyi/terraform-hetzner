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

variable "database" {
  description = "Database Configuration"
  sensitive   = true
  type        = object({
    type     = optional(string, "postgres")
    host     = string
    port     = optional(number, 5432)
    database = optional(string, "gitea")
    user     = optional(string, "gitea")
    password = string
  })
}