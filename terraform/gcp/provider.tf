provider "google" {
  credentials = "${file("${var.credential.data}")}"
  project     = var.project_name
  region      = var.region_name
}
