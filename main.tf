# Configuration of providers
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.52.0"
    }
  }
}

# Defining London region
provider "google" {
  project     = "basic-cat-377409"
}

# Calling the local auth module to create a service account and configure kubeconfig"

# module "auth" {
#   source  = "./modules/auth"
#   version = "1.0.0"
# }

module "gke" {
  source  = "./modules/gke"
}

module "data" {
  source  = "./modules/bigdata"
}