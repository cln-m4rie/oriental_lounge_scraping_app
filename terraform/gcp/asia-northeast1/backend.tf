terraform {
  required_version = ">= 0.12"

  backend "gcs" {
    bucket      = "oriental_lounge"
    credentials = "credentials.json"
  }
}
