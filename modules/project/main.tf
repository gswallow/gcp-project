data "google_folder" "folder" {
  folder = var.folder_name
}

resource "random_id" "project" {
  byte_length=4
}

resource "google_project" "project" {
  name            = "${var.project_name}-${random_id.project.dec}"
  project_id      = "${var.project_name}-${random_id.project.dec}"
  folder_id       = data.google_folder.folder.id
  billing_account = var.billing_account_id
}

resource "google_project_service" "enabled_apis" {
  count                      = length(local.enabled_apis)
  project                    = google_project.project.project_id
  service                    = element(local.enabled_apis, count.index)
  disable_dependent_services = true
}
