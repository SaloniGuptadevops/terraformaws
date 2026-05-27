terraform {
  backend "s3" {
    bucket         = "terraform-state-saloni"
    # Replace with your actual bucket name

    key            = "dev/terraform.tfstate"
    # Path inside bucket where state is stored
    # dev environment gets its own path

    region         = "ap-south-1"

    dynamodb_table = "terraform-lock"
    # Table we created for state locking

    encrypt        = true
    # State file is encrypted at rest in S3
  }
}
