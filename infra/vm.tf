resource "google_compute_instance" "controle-vm" {

  name         = "controle-vm"
  machine_type = "e2-standard-2"
  zone         = "us-west4-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.managment-subnet.id

    access_config {
      // Ephemeral public IP
    }
  }
  metadata_startup_script = file("configurationscript.sh")

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.gcp-project-sa.email
    scopes = ["cloud-platform"]

  }

}
