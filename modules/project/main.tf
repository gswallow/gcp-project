data "google_folder" "folder" {
  folder = var.folder_name
}

resource "google_project" "project" {
  name            = replace("${var.org_name}-${var.project_name}", ".", "-")
  project_id      = replace("${var.org_name}-${var.project_name}", ".", "-")
  folder_id       = data.google_folder.folder.id
  billing_account = var.billing_account_id
  #labels          = merge(local.labels, { "FolderName" = data.google_folder.folder.name, "ProjectName" = var.project_name })
}

resource "google_project_service" "enabled_apis" {
  count                      = length(local.enabled_apis)
  project                    = google_project.project.project_id
  service                    = element(local.enabled_apis, count.index)
  disable_dependent_services = true
}
