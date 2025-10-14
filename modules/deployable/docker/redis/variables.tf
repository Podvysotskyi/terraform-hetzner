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
    enable  = optional(bool, false)
    network = optional(string, "traefik")
  })
  default = {}
}