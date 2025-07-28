variable S3_ENDPOINT {
  type        = string
  default     = "fsn1.your-objectstorage.com"
  description = "The S3 bucket name for object storage."
}

variable S3_BUCKET {
  type        = string
  description = "The S3 bucket name for object storage."
}

variable S3_REGION {
  type        = string
  default     = "main"
  description = "The S3 region for object storage."
}

variable S3_TF_STATE {
  type        = string
  default     = "terraform-hetzner.tfstate"
  description = "description"
}
