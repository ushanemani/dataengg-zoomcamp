terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.26.0"
    }
  }
}

  provider "google" {
    project = "dataengg-zoomcamp"
    region  = "us-central1"
  }

resource "google_storage_bucket" "terraform-demo" {
  name          = "tf-demo-dataengg"
  location      = "US"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 3
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}
