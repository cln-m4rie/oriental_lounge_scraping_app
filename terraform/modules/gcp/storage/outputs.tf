output "storage_bucket_name" {
  value = "${google_storage_bucket.slack_functions_bucket.name}"
}
output "storage_object_name" {
  value = "${google_storage_bucket_object.functions_zip.name}"
}

