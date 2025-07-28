terraform {
  backend "s3" {
    bucket   = "podvysotskyi-github"
    endpoint = "fsn1.your-objectstorage.com"
    key      = "terraform-hetzner/terraform.tfstate"
    region   = "main"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}
