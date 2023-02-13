resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "vmo2_tech_test"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_dataset_access" "access" {
  dataset_id    = google_bigquery_dataset.dataset.dataset_id
  role          = "OWNER"
  user_by_email = google_service_account.bqowner.email
}