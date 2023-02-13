variable "project_id" {
  type = string
}

variable "dataset_name" {
  type = string
  default = "vmo2_tech_test"
}

variable "region" {
  type = string
  default = "EU"
}

variable "bigquery_role_assignment" {
    type = map(object({        
            role = string
            user = string          
    }))
}