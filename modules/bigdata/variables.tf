variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "EU"
}

variable "bigquery_role_assignment" {
  type = map(object({
    role = string
    user = string
  }))
}