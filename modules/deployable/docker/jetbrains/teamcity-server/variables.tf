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
    host    = string
    network = optional(string, "traefik")
  })
}

variable "networks" {
  description = "Docker networks"
  type        = list(string)
  default     = []
}