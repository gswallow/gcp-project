# Create a storage bucket
# - enable versioning
# Create a new project
# - Attach the project to the billing account
# - Attach the project to a shared VPC if it exists
# Create a new service account for the project
# - Give it access to the shared VPC if it exists.

# Roles for the Application Default service account
resource "google_organization_iam_member" "folder_admin" {
  org_id = data.google_organization.org.org_id
  role   = "roles/resourcemanager.folderAdmin"
  member = "domain:${data.google_organization.org.domain}"
}

resource "google_organization_iam_member" "project_creator" {
  org_id = data.google_organization.org.org_id
  role   = "roles/resourcemanager.projectCreator"
  member = "domain:${data.google_organization.org.domain}"
}

resource "google_organization_iam_member" "project_deleter" {
  org_id = data.google_organization.org.org_id
  role   = "roles/resourcemanager.projectDeleter"
  member = "domain:${data.google_organization.org.domain}"
}

resource "google_organization_iam_member" "project_mover" {
  org_id = data.google_organization.org.org_id
  role   = "roles/resourcemanager.projectMover"
  member = "domain:${data.google_organization.org.domain}"
}

# Create a for loop that maps folders and projects
resource "google_folder" "folder" {
  display_name = var.folder_name
  parent = data.google_organization.org.name
}

resource "google_project" "project" {
  name   = var.project_name
  project_id = replace("${var.org_domain}-${var.project_name}", ".", "-")
  folder_id = google_folder.folder.name
  billing_account = var.billing_account_id
}

resource "google_project_service" "enabled_apis" {
  count = length(var.enabled_apis)
  project = google_project.project.project_id
  service = var.enabled_apis[count.index]
}
