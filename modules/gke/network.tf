resource "google_compute_network" "vpc" {
  name = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name                     = var.gcp_region
  network                  = google_compute_network.vpc.id
  region                   = var.gcp_region
  ip_cidr_range            = "10.0.0.0/24"
  private_ip_google_access = true
}

resource "google_compute_router" "vpc_router" {
  name    = var.gcp_region
  region  = var.gcp_region
  network = google_compute_network.vpc.self_link
}

resource "google_compute_router_nat" "vpc_nat" {
  name   = var.gcp_region
  region = var.gcp_region
  router = google_compute_router.vpc_router.name

  nat_ip_allocate_option = "AUTO_ONLY"
  # "Manually" define the subnetworks for which the NAT is used, so that we can exclude the public subnetwork
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.subnet.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}