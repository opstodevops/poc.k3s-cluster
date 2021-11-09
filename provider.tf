# provider "aws" {
#   region     = var.AWS_REGION
#   access_key = var.AWS_ACCESS_KEY
#   secret_key = var.AWS_SECRET_KEY
# }

####################
# PROVIDERS
####################


provider "aws" {
  region                  = var.AWS_REGION
  profile                 = "default"
  shared_credentials_file = "~/.aws/credentials"

  default_tags {
    tags = {
      Owner        = "Terraform"
      PortfolioTag = "k3s-poc"
      ProductTag   = "k3s-poc"
      UUID         = 123456
    }
  }

  # assume_role {
  #   role_arn = "arn:aws:iam::${data..account.aws_id}:role/${var.iam_role}"
  # }

  # ignore_tags {
  #   key_prefixes = ["managed:"]
  # }

}