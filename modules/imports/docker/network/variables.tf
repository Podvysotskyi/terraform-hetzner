variable "docker" {
  description = "Docker Configuration"
  type        = object({
    host = string
  })
}

variable "name" {
  description = "Network name"
  type = string
}