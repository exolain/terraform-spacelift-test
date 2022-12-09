terraform {
  required_providers {
    google = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  skip_credentials_validation = true
}

module "my_workerpool" {
  source = "github.com/spacelift-io/terraform-aws-spacelift-workerpool-on-ec2"

  configuration = <<-EOT
    export SPACELIFT_TOKEN="${var.worker_pool_config}"
    export SPACELIFT_POOL_PRIVATE_KEY="${var.worker_pool_private_key}"
    export HTTPS_PROXY="http://usaeast-proxy.us.experian.eeca:9595"
    export HTTP_PROXY="http://usaeast-proxy.us.experian.eeca:9595"
    export NO_PROXY="169.254.169.254,localhost,127.0.0.1,.experiannet.corp,.aln.experian.com,.experian.eeca,.mck.experian.com,.sch.experian.com,.experian.local,.experian.corp,.gdc.local,.41web.internal,10.8.60.100,10.188.14.49,10.156.225.164,metadata.google.internal,metadata,10.188.14.56"
   
  EOT

  max_size          = 1
  worker_pool_id    = var.worker_pool_id
  security_groups   = var.worker_pool_security_groups
  vpc_subnets       = var.worker_pool_subnets
}
