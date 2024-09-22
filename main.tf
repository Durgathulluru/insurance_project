terraform {
 required_version = ">= 1.9.6"
 required_providers {
   vault = {
          source = "hashicorp/vault"
          version = ">= 1.17.0"
   }
   aws = {
       source = "hashicorp/aws"
       version = ">=3.0.0" 
  }
 }
}
