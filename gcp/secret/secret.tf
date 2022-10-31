resource "google_secret_manager_secret" "secret-basic" {
  secret_id = "test-secret"

  labels = {
    label = "my-label"
    owner = "bob"
  }

  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret = google_secret_manager_secret.secret-basic.id

  secret_data = var.secretvalue
}

provider "google" {
  project     = "alexs-project-239406"
  region      = "us-west1"
}

output "hello" {
  value = google_secret_manager_secret_version.secret-version-basic.secret_data
  sensitive = true
}

variable "secretvalue" {
  type    = string
  default = "test"
}
