resource "google_folder" "folder" {
  display_name = var.folder_name
  parent       = var.parent_org_id
}

resource "google_folder_iam_policy" "folder" {
  folder      = google_folder.folder.name
  policy_data = data.google_iam_policy.folder.policy_data
}

data "google_iam_policy" "folder" {
  binding {
    role    = "roles/viewer"
    members = var.folder_viewers
  }
}
