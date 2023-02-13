# Configuration of providers
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.52.0"
    }
  }
}

provider "google" {
  project     = var.project_id
}

module "apis" {
  source  = "./modules/api"
  project_id = var.project_id
}

module "gke" {
  source  = "./modules/gke"
  project_id = var.project_id
  gcp_region = "europe-west2"
  gke_master_ip_cidr = "192.168.0.0/28"
  service_account = "gkevmsvcacct"
  cluster_name = "vm-gke-cluster"
  node_pool_1_name = "nodepool1"
  node_pool_2_name =  "nodepool2"
  node_pool_1_count = 1
  node_pool_2_min_count = 0
  node_pool_2_max_count = 3
  vpc_name = "vm-gke-vpc"
}

module "data" {
  source  = "./modules/bigdata"

  project_id = var.project_id

  ## Changed to OWNER as the documentation reccomends that otherwise it will reflect a change each time.
  ## https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset_access

  bigquery_role_assignment = {
    vmo2_tech_test = {                    # dataset name 
      role = "OWNER"  # gcp role
      user = "StefanThomasLock@gmail.com"       # google email address of user
    }
  }
}