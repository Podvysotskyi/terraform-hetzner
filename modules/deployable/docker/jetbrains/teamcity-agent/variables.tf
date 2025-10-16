variable "docker" {
  description = "Docker Configuration"
  type        = object({
    host = string
    path = optional(string, "/home/docker")
  })
}

variable "teamcity" {
  description = "TeamCity Configuration"
  type        = object({
    host    = string
    network = string
  })
}