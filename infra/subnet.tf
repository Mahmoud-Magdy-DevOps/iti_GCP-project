resource "google_compute_subnetwork" "workload-subnet" {
  name          = "workload-subnet"
  ip_cidr_range = "10.2.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_subnetwork" "managment-subnet" {
  name          = "managment-subnet"
  ip_cidr_range = "10.3.0.0/16"
  region        = "us-west4"
  network       = google_compute_network.vpc_network.name
}
