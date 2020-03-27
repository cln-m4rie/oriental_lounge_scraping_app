variable "project_name" {
  default = ""
}

variable "credential" {
  default = {
    data = "credentials.json"
  }
}

variable "webhook" {
  default = {
    url = ""
  }
}

variable "region_name" {
  default = "asia-northeast1"
}
