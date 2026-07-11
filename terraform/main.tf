resource "google_storage_bucket" "log_bucket" {
  #checkov:skip=CKV_GCP_62:Log bucket is the terminal destination, does not need its own logging
  name                        = "my-secure-demo-logs-123"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "secure_bucket" {
  name                        = "my-secure-demo-bucket-123"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  logging {
    log_bucket = google_storage_bucket.log_bucket.name
  }
}

resource "google_compute_firewall" "allow_ssh_restricted" {
  name    = "allow-ssh-restricted"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["203.0.113.0/24"]
}
