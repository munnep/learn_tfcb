terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.16.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("${path.module}/credentials.json")
  project     = "hc-5372532dbacb4863afdfdc0d508"
  region      = "us-central1"
  #   zone        = var.availabilityZone
}

data "google_compute_zones" "available" {
}


data "google_container_engine_versions" "central1b" {
  location       = "us-central1-b"
  version_prefix = "1.21."
}

output "kubernetes_version" {
    value = data.google_container_engine_versions.central1b.latest_node_version
}