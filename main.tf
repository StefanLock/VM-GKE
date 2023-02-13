# Configuration of providers
terraform {
  required_version = "1.3.8"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.52.0"
    }
  }
}

provider "google" {
  project = var.project_id
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
  source = "./modules/bigdata"

  project_id = var.project_id

  bigquery_role_assignment = {
    vmo2_tech_test = {
      role = "READER"
      user = "StefanThomasLock@gmail.com"
    }
  }
}