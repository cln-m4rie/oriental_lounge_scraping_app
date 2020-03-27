resource "google_cloudfunctions_function" "oriental-lounge_scraping_function" {
  name        = "OrientalLoungeScrapingFunction"
  project     = var.project_name
  region      = var.region_name
  runtime     = "python37"
  entry_point = "run"

  source_archive_bucket = "${google_storage_bucket.slack_functions_bucket.name}"
  source_archive_object = "${google_storage_bucket_object.functions_zip.name}"

  environment_variables = {
    SLACK_WEBHOOK_URL = "${var.webhook.url}"
  }

  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = "${google_pubsub_topic.oriental_lounge_topic.name}"
  }
}
