variable "credentials" {
  description = "The path to the service account key file"
  default     = "./keys/my-creds.json"
}

variable "project_id" {
  description = "The GCP project ID"
  default     = "terraform-demo-87"
}

variable "region" {
  description = "The region for the resources"
  default     = "eu-west1"

}

variable "location" {
  description = "The location/region for the resources"
  default     = "EU"
}

variable "bq_dataset_name" {
  description = "My BQ dataset name"
  default     = "demo_dataset"
}

variable "gcs_bucket_name" {
  description = "Name of the GCS bucket"
  default     = "terraform-demo-87-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Storage class for GCS bucket"
  default     = "STANDARD"
}