variable "docker" {
  description = "Docker Configuration"
  type        = object({
    host = string
  })
}

variable "network" {
  description = "Network Configuration"
  type        = object({
    name     = string
    internal = optional(bool, false)
  })
}