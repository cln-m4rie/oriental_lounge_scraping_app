resource "google_cloud_scheduler_job" "oriental_lounge_scraping_app_job" {
  name        = "oriental_lounge_scraping_app_job"
  project     = var.project_name
  description = "oriental_lounge_scraping_app_job"
  schedule    = "*/10 * * * *"
  time_zone   = "Asia/Tokyo"

  pubsub_target {
    topic_name = google_pubsub_topic.oriental_lounge_topic.id
    data       = base64encode("test")
  }
}
