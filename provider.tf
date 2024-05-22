/* Configure the AWS Provider */
provider "aws" {
  access_key = var.access_key
  region     = "us-east-1"
  secret_key = var.secret_key
}

# terraform {
#   backend "s3" {
#     bucket         = "paula-hakeem-paula-hakeem"
#     key            = "terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform_state"
#   }
# }