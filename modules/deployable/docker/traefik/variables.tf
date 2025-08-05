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

variable "cloudflare" {
  description = "Cloudflare configuration"
  type        = object({
    email = string
    token = string
  })
}

variable "http_port" {
  description = "The HTTP port"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "The HTTPS port"
  type        = number
  default     = 443
}

variable "tcp_ports" {
  description = "The TCP ports"
  type        = list(object({
    port   = number
    target = optional(number, null)
  }))
  default     = []
}

variable "udp_ports" {
  description = "The UDP ports"
  type        = list(object({
    port   = number
    target = optional(number, null)
  }))
  default     = []
}
