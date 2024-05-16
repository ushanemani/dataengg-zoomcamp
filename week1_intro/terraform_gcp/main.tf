terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.26.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}



# DWH
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
resource "google_bigquery_dataset" "ny-taxi-data" {
  dataset_id = var.BQ_DATASET
  project    = var.project
  location   = var.region
}
