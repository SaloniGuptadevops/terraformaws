terraform {
  backend "s3" {
    bucket         = "terraform-state-saloni"
    # Same bucket — different key

    key            = "prod/terraform.tfstate"
    # prod environment gets its own path
    # dev and prod state files are separate

    region         = "ap-south-1"

    dynamodb_table = "terraform-lock"

    encrypt        = true
  }
}
