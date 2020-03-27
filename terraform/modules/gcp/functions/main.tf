resource "google_cloudfunctions_function" "oriental-lounge_scraping_function" {
  name        = "OrientalLoungeScrapingFunction"
  runtime     = "python37"
  entry_point = "run"

  source_archive_bucket = var.storage_bucket_name
  source_archive_object = var.storage_object_name

  environment_variables = {
    SLACK_WEBHOOK_URL = var.slack_webhook_url
  }

  event_trigger {
    event_type = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource   = var.oriental_lounge_topic_name
  }
}
