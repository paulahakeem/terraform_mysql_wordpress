/* Configure the AWS Provider */
provider "aws" {
  access_key = var.access_key
  region     = "us-east-1"
  secret_key = var.secret_key
}

