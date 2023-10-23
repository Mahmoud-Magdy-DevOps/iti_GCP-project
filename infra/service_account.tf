resource "google_service_account" "gcp-project-sa" {
  account_id   = "gcp-project-service-account"
  display_name = "Service Account"
  description  = "Service account for GCP project"
  project      = "iti-project-401403"
}


## Trying to bind the service account to the VM so it can be used to create the artifacts registry.
#resource "google_project_iam_binding" "service_account_binding" {
#  role    = "roles/storage.admin"
#  members = ["serviceAccount:${google_service_account.gcp-project-sa.id}"]
#  project = var.gcp_project
#}
