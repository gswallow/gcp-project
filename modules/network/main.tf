locals {
  service_projects = tolist(setsubtract(toset(data.google_projects.projects_in_folder.projects[*].project_id), toset([data.google_project.project.project_id])))
}

data "google_project" "project" {
  project_id = var.project_id
}

data "google_folder" "parent" {
  folder = var.parent_folder_name
}

data "google_projects" "projects_in_folder" {
  filter = "parent.id:${replace(data.google_folder.parent.id, "folders/", "")}"
}

resource "google_compute_network" "network" {
  name = var.name
  project = data.google_project.project.project_id
  auto_create_subnetworks = var.auto_create_subnets
  description = "Shared VPC for projects in the ${var.parent_folder_name} folder"
  routing_mode = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = data.google_project.project.project_id
}

resource "google_compute_shared_vpc_service_project" "service" {
  count = length(local.service_projects)
  host_project = google_compute_shared_vpc_host_project.host.project
  service_project = element(local.service_projects, count.index)
}