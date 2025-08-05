variable "docker" {
  description = "Docker Configuration"
  type        = object({
    host = string
  })
}

variable "container" {
  description = "Container Configuration"
  type        = object({
    name    = string
    image   = string
    version = optional(string, "latest")

    networks = optional(list(string), [])

    command = optional(list(string), [])

    env = optional(list(string), [])

    ports = optional(list(object({
      container = number
      host      = number
      protocol  = optional(string, "tcp")
    })), [])

    volumes = optional(list(object({
      source      = string
      destination = string
      read_only   = optional(bool, false)
    })), [])

    labels = optional(list(object({
      key   = string
      value = string
    })), [])
  })
}

variable "traefik" {
  description = "Enable traefik"

  type = object({
    enable  = bool
    network = optional(string, null)

    http = optional(object({
      port         = number
      host         = string
      scheme       = optional(string, "http")
      certresolver = optional(string, "cloudflare")
    }), null)

    tcp = optional(object({
      port   = number
      host   = optional(string, "*")
    }), null)

    udp = optional(object({
      port   = number
      host   = optional(string, "*")
    }), null)
  })

  default = {
    enable = false
  }
}