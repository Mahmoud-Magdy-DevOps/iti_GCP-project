resource "google_service_account" "service_account" {
  account_id   = "gcp-project-service-account-id"
  display_name = "Service Account"
  description  = "Service account for GCP project"
  project      = "iti-project-401403"
}
