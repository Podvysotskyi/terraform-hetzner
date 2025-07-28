terraform {
    backend "s3" {
        bucket   = var.S3_BUCKET
        endpoint = var.S3_ENDPOINT
        key      = var.S3_TF_STATE
        region   = var.S3_REGION

        skip_credentials_validation = true
        skip_metadata_api_check     = true
        skip_region_validation      = true
    }
}

resource "null_resource" "example" {
    triggers = {
        value = "A example resource that does nothing!"
    }
}
