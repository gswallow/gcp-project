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
  name                            = var.name
  project                         = data.google_project.project.project_id
  auto_create_subnetworks         = var.auto_create_subnets
  description                     = "Shared VPC for projects in the ${var.parent_folder_name} folder"
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

resource "google_compute_shared_vpc_host_project" "host" {
  project = data.google_project.project.project_id
}

resource "google_compute_shared_vpc_service_project" "service" {
  count           = var.number_of_service_projects
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = element(tolist(setsubtract(toset(data.google_projects.projects_in_folder.projects[*].project_id), toset([data.google_project.project.project_id]))), count.index)
}

resource "google_project_iam_binding" "network_user" {
  project = google_compute_shared_vpc_host_project.host.project
  role    = "roles/compute.networkUser"

  members = [for account in var.service_project_service_accounts : "serviceAccount:${account}"]
}

resource "google_compute_subnetwork" "subnetwork" {
  count = length(var.gcp_regions)

  name          = "${element(var.gcp_regions, count.index)}-${replace(replace(cidrsubnet(var.cidr_block, local.new_bits, count.index), ".", "-"), "/", "-")}"
  region        = element(var.gcp_regions, count.index)
  project       = data.google_project.project.project_id
  network       = google_compute_network.network.id
  ip_cidr_range = cidrsubnet(var.cidr_block, local.new_bits, count.index)
}

resource "google_compute_route" "default" {
  name             = "default-route"
  dest_range       = "0.0.0.0/0"
  network          = google_compute_network.network.name
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  project          = data.google_project.project.project_id
}
