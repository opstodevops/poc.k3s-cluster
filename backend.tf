####################
# S3 BACKEND
####################

// Send the state to our S3 bucket. Only the key should be changed.
// All the other parameters are fixed regardless of the account/region 
// the template will use.

# terraform {
#   backend "s3" {
#     bucket         = "xero-ps-eventing-svc-terraform-statelock"
#     region         = "ap-southeast-2"
#     dynamodb_table = "ps-eventing-svc-terraform-statelock"
#     encrypt        = "true"
#     role_arn       = "arn:aws:iam::714939102551:role/X-AdminAccess" #temporary solution

#     key = "TerraformRepo/ap-southeast-2/k3s-aws-terraform-cluster/terraform.tfstate"
#   }
# }