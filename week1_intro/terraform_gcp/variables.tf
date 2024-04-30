locals {
  data_lake_bucket = "tf-demo-dataengg"
}

variable "project" {
  description = "Your Project ID here"
  default     = "dataengg-zoomcamp"
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default     = "us-central1"
  type        = string
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default     = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type        = string
  default     = "trips_data_all"
}

variable "TABLE_NAME" {
  description = "BigQuery Table"
  type        = string
  default     = "ny_trips"
}