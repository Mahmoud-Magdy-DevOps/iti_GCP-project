resource "google_service_account" "cp-project-sa" {
  account_id   = "gcp-project-service-account"
  display_name = "Service Account"
  description  = "Service account for GCP project"
  project      = "iti-project-401403"
}
