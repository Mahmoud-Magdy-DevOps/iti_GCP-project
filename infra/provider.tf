#GCP profider

provider "google" {
  credentials = file("gcp_svc_key.json")
  project     = var.gcp_project
  region      = "us-central1"
  zone        = "us-central1-c"
}
