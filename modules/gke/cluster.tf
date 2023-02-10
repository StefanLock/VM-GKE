resource "google_container_cluster" "primary" {
  name     = "vm-gke-cluster"
  location = var.gcp_region
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
  initial_node_count  = 1

  master_authorized_networks_config {}
  ip_allocation_policy {}

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "192.168.0.0/28"
  }
}

resource "google_container_node_pool" "secondarynodes" {
    name               = "nodepool1"
    location           = var.gcp_region
    cluster            = google_container_cluster.primary.id
    initial_node_count = 0
  
    autoscaling {
        # Minimum number of nodes in the NodePool. Must be >=0 and <= max_node_count.
        min_node_count = 0

        # Maximum number of nodes in the NodePool. Must be >= min_node_count.
        max_node_count = 3
    }

    node_config {
        oauth_scopes = [
            # https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#nested_node_config
            "https://www.googleapis.com/auth/cloud-platform",
        ]

        preemptible  = true
    }
}