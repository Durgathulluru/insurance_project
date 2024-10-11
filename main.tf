terraform {
 required_version = ">= 1.9.7"
 required_providers {
   vault = {
          source = "hashicorp/vault"
          version = ">= 1.18.0"
   }
   aws = {
       source = "hashicorp/aws"
       version = ">=3.0.0" 
  }
 }
}
