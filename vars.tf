# variable "AWS_ACCESS_KEY" {

# }

# variable "AWS_SECRET_KEY" {

# }

variable "AWS_REGION" {
  default     = "ap-southeast-2"
  description = "AWS Zone"
}

variable "AMIS" {
  type = map(string)
  default = {
    ap-southeast-2 = "ami-0567f647e75c7bc05"
    us-east-1      = "ami-0ae74ae9c43584639"
    us-west-2      = "ami-09f5b7791a4e85729"
    eu-west-1      = "ami-0da36f7f059b7086e"
  }
  description = "Ami image to use"
}

# variable "PATH_TO_PUBLIC_KEY" {
#   default     = "~/.ssh/id_rsa.pub"
#   description = "Path to your public key"
# }

# variable "PATH_TO_PRIVATE_KEY" {
#   default     = "~/.ssh/id_rsa"
#   description = "Path to your private key"
# }

variable "cluster_name" {
  type        = string
  default     = "k3s-cluster"
  description = "Cluster name"
}

variable "vpc_id" {
  type        = string
  default     = "vpc-0c0537324b4a8cdcd"
  description = "The vpc id"
}

# variable "instance_profile_name" {
#   type        = string
#   default     = "AWSEC2ReadOnlyAccess"
#   description = "The name of the instance profile to use"
# }

variable "my_public_ip_cidr" {
  type        = string
  default     = "0.0.0.0/32" # curl ifconfig.me
  description = "My public ip CIDR"
}

variable "vpc_subnet_cidr" {
  type        = string
  default     = "172.31.0.0/16"
  description = "VPC subnet CIDR"
}

variable "vpc_subnets" {
  type        = list(any)
  default     = ["subnet-0af7e18735801b50f", "subnet-0632b5247009cd914", "subnet-05510c44c140df32c"]
  description = "The vpc subnets ids"
}

variable "k3s_token" {
  default     = "afwLKyAOmHjpeuDOkEc1Mdrn2iXDrDk7"
  type        = string
  description = "Override to set k3s cluster registration token"
}