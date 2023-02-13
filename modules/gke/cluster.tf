resource "google_service_account" "gkeserviceaccount" {
  account_id   = var.service_account
  display_name = var.service_account
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.gcp_region
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  remove_default_node_pool = true
  initial_node_count       = 1

  master_authorized_networks_config {}
  ip_allocation_policy {}

  resource_labels = {
      project = var.project_id
      env = "vm_cluster_example"
  }

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.gke_master_ip_cidr
  }
}

resource "google_container_node_pool" "primarynodes" {
    name               = var.node_pool_1_name
    location           = var.gcp_region
    cluster            = google_container_cluster.primary.id
    ## Set to 1 as I ran into quota issues using a the GCP free trial
    initial_node_count = var.node_pool_1_count

    management {
        auto_repair = true
        auto_upgrade = true
    }

    node_config {
        service_account = google_service_account.gkeserviceaccount.email
        machine_type = "e2-micro"

        labels = {
            project = var.project_id
            env = "vm_cluster_example"
        }
    }
}

resource "google_container_node_pool" "secondarynodes" {
    name               = var.node_pool_2_name
    location           = var.gcp_region
    cluster            = google_container_cluster.primary.id
    initial_node_count = 0
  
    autoscaling {
        # Minimum number of nodes in the NodePool. Must be >=0 and <= max_node_count.
        min_node_count = var.node_pool_2_min_count

        # Maximum number of nodes in the NodePool. Must be >= min_node_count.
        max_node_count = var.node_pool_2_max_count
    }

    management {
        auto_repair = true
        auto_upgrade = true
    }

    node_config {
        service_account = google_service_account.gkeserviceaccount.email
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform",
        ]
        machine_type = "e2-micro"

        labels = {
            project = var.project_id
            env = "vm_cluster_example"
        }
        preemptible  = true
    }
}