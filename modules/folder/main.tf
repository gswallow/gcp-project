resource "google_folder" "folder" {
  display_name = var.folder_name
  parent       = var.parent_org_id
}

resource "google_folder_iam_member" "viewer" {
  count = length(var.folder_viewers)
  folder  = google_folder.folder.name
  role    = "roles/viewer"
  member  = element(var.folder_viewers, count.index)
}

data "google_iam_policy" "folder" {
  binding {
    role    = "roles/viewer"
    members = var.folder_viewers
  }
}
