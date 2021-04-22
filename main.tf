provider "aws" {
  region = "us-west-2"
}

module "vault-oss" {
  source                = "hashicorp/vault-starter/aws"
  version               = "0.2.3"
  allowed_inbound_cidrs = ["0.0.0.0/0"]
  vpc_id                = "vpc-0133b9d9281c2d115"
  vault_version         = "1.7.1"
  owner                 = "sean.carolan@hashicorp.com"
  name_prefix           = "seanc"
  key_name              = "scarolan"
  elb_internal          = false
}
