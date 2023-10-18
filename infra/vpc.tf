resource "google_compute_network" "vpc_network" {
  name                    = "iti-project-vpc"
  auto_create_subnetworks = false
}
