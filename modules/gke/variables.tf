variable "project_id" {
  type = string
}

### CLUSTER CONFIGURATION

variable "gcp_region" {
  description = "The region into which we want to launch the infrastructure"
  type        = string
  default     = "europe-west2"
}

variable "gke_master_ip_cidr" {
  type    = string
  default = "192.168.0.0/28"
}

variable "service_account" {
  type    = string
  default = "gkevmsvcacct"
}

variable "cluster_name" {
  type    = string
  default = "vm-gke-cluster"
}

variable "node_pool_1_name" {
  type    = string
  default = "nodepool1"
}

variable "node_pool_2_name" {
  type    = string
  default = "nodepool2"
}

variable "node_pool_1_count" {
  type    = number
  default = 1
}

variable "node_pool_2_min_count" {
  type    = number
  default = 0
}

variable "node_pool_2_max_count" {
  type    = number
  default = 3
}

### NETWORK CONFIGURATION

variable "vpc_name" {
  type    = string
  default = "vm-gke-vpc"
}