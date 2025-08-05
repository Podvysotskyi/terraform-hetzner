variable "destination" {
  description = "File destination path"
  type        = string
}

variable "content" {
  description = "File content"
  type        = string
  default     = null
}

variable "path" {
  description = "File source"
  type    = string
  default = null
}

variable "ssh" {
  type = object({
    user = string
    host = string
    port = optional(number, 22)
  })
}