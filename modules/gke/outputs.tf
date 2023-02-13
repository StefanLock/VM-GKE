### CLUSTER CONFIGURATION

output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "region" {
  value = google_container_cluster.primary.location
}

### NETWORK CONFIGURATION

output "vpc" {
  value = google_compute_network.vpc.name
}