resource "google_bigquery_dataset" "dataset" {
  location                    = var.region
  default_table_expiration_ms = 3600000

  ## loop through passed variables and assign the key as the dataset_id
  for_each   = var.bigquery_role_assignment
  dataset_id = each.key

  labels = {
    project = var.project_id
    env     = "vm_bigquery_example"
  }
}

resource "google_bigquery_dataset_access" "access" {
  project = var.project_id

  ## Loop through variables and parse values for the access resource. 
  for_each      = var.bigquery_role_assignment
  dataset_id    = each.key
  role          = each.value.role
  user_by_email = each.value.user

  depends_on = [google_bigquery_dataset.dataset]
}
