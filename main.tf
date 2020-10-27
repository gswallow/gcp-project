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

module "google_folder" {
  source = "./modules/folder"
  for_each = { for folder in var.folders : folder.name => folder }

  parent_org_id = data.google_organization.org.name
  folder_name   = each.value.name
  folder_editors = each.value.editors
  folder_viewers = each.value.viewers
  depends_on    = [google_organization_iam_member.folder_admin, google_organization_iam_member.project_creator]
}

module "google_project" {
  source   = "./modules/project"
  for_each = { for project in var.projects : project.project_name => project }

  billing_account_id = var.billing_account_id
  org_name           = var.org_domain
  folder_name        = module.google_folder[each.value.folder_name].folder_name
  project_name       = each.value.project_name
  project_users      = each.value.project_users
  enabled_apis       = each.value.enabled_apis

  depends_on = [module.google_folder]
}
