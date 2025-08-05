variable "vault" {
  description = "Vault configuration"
  type        = object({
    host  = string
    token = string
  })
}

variable "path" {
  type = string
}

variable "data" {
  type = any
}