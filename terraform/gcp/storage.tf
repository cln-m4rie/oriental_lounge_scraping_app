data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../src"
  output_path = "${path.module}/../../src.zip"
}

resource "google_storage_bucket" "slack_functions_bucket" {
  name          = "${var.project_name}-scheduler-bucket"
  project       = var.project_name
  location      = var.region_name
  force_destroy = true
}

resource "google_storage_bucket_object" "functions_zip" {
  name   = "src.zip"
  bucket = "${google_storage_bucket.slack_functions_bucket.name}"
  source = "${path.module}/../../src.zip"
}
