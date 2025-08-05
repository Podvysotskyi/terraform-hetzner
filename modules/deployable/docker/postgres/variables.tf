variable "docker" {
  description = "Docker Configuration"
  type        = object({
    host = string
    path = optional(string, "/home/docker")
  })
}

variable "traefik" {
  description = "Traefik Configuration"
  type        = object({
    network = optional(string, "traefik")
  })
  default = {}
}

variable "postgres" {
  description = "Postgess Configuration"
  sensitive   = true
  type        = object({
    user     = optional(string, "postgres")
    password = optional(string, "postgres")
    database = optional(string, "postgres")
  })
  default = {}
}
