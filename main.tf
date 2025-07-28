terraform {
  backend "s3" {
    bucket   = "podvysotskyi-github"
    endpoint = "https://fsn1.your-objectstorage.com"
    key      = "terraform-hetzner/terraform.tfstate"

    region                      = "main" # this is required, but will be skipped!
    skip_credentials_validation = true   # this will skip AWS related validation
    skip_metadata_api_check     = true
    skip_region_validation      = true
  }
}
