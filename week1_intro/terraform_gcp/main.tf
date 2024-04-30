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

resource "google_storage_bucket" "terraform-demo" {
  name                        = "${local.data_lake_bucket}_${var.project}"
  # Concatenating DL bucket & Project name for unique naming
  location                    = var.region
  force_destroy               = true
  # Optional, but recommended settings:
  storage_class               = var.storage_class
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 85
    }
    action {
      type = "Delete"
    }
  }
}


# DWH
# Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/bigquery_dataset
resource "google_bigquery_dataset" "demo-dataset" {
  dataset_id = var.BQ_DATASET
  project    = var.project
  location   = var.region
}
