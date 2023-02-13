resource "google_project_service" "compute" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_project_service" "kubernetes" {
  project = var.project_id
  service = "container.googleapis.com"
}

resource "google_project_service" "billing" {
  project = var.project_id
  service = "cloudbilling.googleapis.com"
}