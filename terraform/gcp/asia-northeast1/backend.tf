terraform {
  required_version = ">= 0.11.0"

  backend "gcs" {
    bucket      = "oriental_lounge"
    credentials = "credentials.json"
  }
}
