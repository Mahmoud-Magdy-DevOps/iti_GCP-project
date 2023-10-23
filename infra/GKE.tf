# GKE Cluster
resource "google_container_cluster" "gke_cluster" {
  name                     = "gke-cluster"
  location                 = "us-central1"
  initial_node_count       = 1
  deletion_protection      = "false"
  remove_default_node_pool = true
  network                  = google_compute_network.vpc_network.id
  subnetwork               = google_compute_subnetwork.workload-subnet.id

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/24"
      display_name = "managment-cidr-range"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.16.0.0/16"
    services_ipv4_cidr_block = "10.12.0.0/16"
  }
}
################################################################
#resource "google_container_cluster_role_binding" "gke_service_account_binding" {
#  cluster = google_container_cluster.gke_cluster.name
#  role    = "roles/container.clusterAdmin"
#  members = ["serviceAccount:${google_service_account.gcp-project-sa.email}"]
#}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.gke_cluster.id
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gcp-project-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
