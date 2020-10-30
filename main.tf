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

resource "google_organization_iam_member" "enable_xpn_host" {
  org_id = data.google_organization.org.org_id
  role   = "roles/compute.xpnAdmin"
  member = "domain:${data.google_organization.org.domain}"
}

module "google_folder" {
  source   = "./modules/folder"
  for_each = { for folder in var.folders : folder.name => folder }

  parent_org_id  = data.google_organization.org.name
  folder_name    = each.value.name
  folder_viewers = each.value.viewers
  depends_on     = [google_organization_iam_member.folder_admin, google_organization_iam_member.project_creator]
}

module "google_project" {
  source   = "./modules/project"
  for_each = { for project in var.projects : project.identifier => project }

  billing_account_id      = var.billing_account_id
  org_name                = var.org_domain
  folder_name             = module.google_folder[each.value.folder_name].folder_name
  project_name            = each.value.project_name
  enabled_apis            = each.value.enabled_apis
  auto_create_network     = each.value.auto_create_network
  role_bindings           = try(each.value.role_bindings, [])
  bucket_name             = replace("${var.org_domain}-${each.value.folder_name}-${each.value.project_name}-terraform", ".", "-")
  terraform_impersonators = try(each.value.terraform_impersonators, [])

  depends_on = [module.google_folder]
}

module "google_network" {
  source   = "./modules/network"
  for_each = { for network in var.networks : network.name => network }

  name                            = each.value.name
  project_id                      = module.google_project[each.value.host_project_identifier].project_id
  parent_folder_name              = module.google_folder[each.value.parent_folder_name].folder_name
  number_of_service_projects      = length([for project in var.projects : project.folder_name if project.folder_name == each.value.parent_folder_name]) - 1
  auto_create_subnets             = try(each.value.auto_create_subnets, false)
  routing_mode                    = try(each.value.routing_mode, "REGIONAL")
  delete_default_routes_on_create = try(each.value.delete_default_routes_on_create, true)
  cidr_block                      = try(each.value.cidr_block, "10.100.0.0/16")
  gcp_regions                     = try(each.value.gcp_regions, ["us-central1", "us-east1", "us-west1"])
  subnet_cidr_suffix              = try(each.value.subnet_cidr_suffix, 20)

  depends_on = [google_organization_iam_member.enable_xpn_host, module.google_folder, module.google_project]
}
