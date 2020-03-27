module "storage" {
  source = "../../modules/gcp/storage"
}

module "pubsub" {
  source = "../../modules/gcp/pubsub"
}

module "scheduler" {
  source                = "../../modules/gcp/scheduler"
  oriental_lounge_topic = "${module.pubsub.oriental_lounge_topic}"
}

module "functions" {
  source                     = "../../modules/gcp/functions"
  storage_bucket_name        = "${module.storage.storage_bucket_name}"
  storage_object_name        = "${module.storage.storage_object_name}"
  oriental_lounge_topic_name = "${module.pubsub.oriental_lounge_topic.name}"
  slack_webhook_url          = "${var.webhook.url}"
}





