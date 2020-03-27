variable "project_name" {
  default = "<your-project-name>"
}

variable "credential" {
  default = {
    data = "<your-credential-json>"
  }
}

variable "webhook" {
  default = {
    url = "<your-slack-webhook-url>"
  }
}

variable "region_name" {
  default = "asia-northeast1"
}

