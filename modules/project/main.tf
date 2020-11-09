data "google_folder" "folder" {
  folder = var.folder_name
}

resource "random_id" "project" {
  byte_length = 4
}

resource "google_project" "project" {
  name                = "${var.project_name}-${random_id.project.dec}"
  project_id          = "${var.project_name}-${random_id.project.dec}"
  folder_id           = data.google_folder.folder.id
  billing_account     = var.billing_account_id
  auto_create_network = var.auto_create_network
}

resource "google_project_service" "enabled_apis" {
  count                      = length(local.enabled_apis)
  project                    = google_project.project.project_id
  service                    = element(local.enabled_apis, count.index)
  disable_dependent_services = true
}

resource "google_service_account" "terraform" {
  account_id   = "terraform"
  display_name = "terraform"
  description  = "Terraform Infrastructure Provisioner"
  project      = google_project.project.name
}

# Specify the IAM policy for the terraform service account
data "google_iam_policy" "terraform" {
  dynamic "binding" {
    for_each = local.role_bindings
    content {
      role = binding.value
      members = [
        "serviceAccount:${google_service_account.terraform.email}"
      ]
    }
  }

  audit_config {
    service = "allServices"
    audit_log_configs {
      log_type = "DATA_READ"
    }

    audit_log_configs {
      log_type = "DATA_WRITE"
    }

    audit_log_configs {
      log_type = "ADMIN_READ"
    }
  }
}

resource "google_project_iam_policy" "terraform" {
  project     = google_project.project.name
  policy_data = data.google_iam_policy.terraform.policy_data
}

resource "google_service_account_iam_binding" "terraform_impersonate" {
  service_account_id = google_service_account.terraform.id
  role               = "roles/iam.serviceAccountTokenCreator"
  members            = var.terraform_impersonators
}

# Storage bucket for Terraform states
resource "google_storage_bucket" "terraform" {
  name     = var.bucket_name
  location = "US"
  project  = google_project.project.name

  versioning {
    enabled = true
  }
}
