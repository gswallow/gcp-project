variable "folder_name" {
  description = "The name of the folder to create"
  type        = string
}

variable "folder_editors" {
  description = "A list of folder editors (administrators)"
  type        = list(string)
  default     = []
}

variable "folder_viewers" {
  description = "A list of folder viewers (read-only accounts)"
  type        = list(string)
  default     = []
}

variable "parent_org_id" {
  description = "The ID of the parent organization for the folder"
  type        = string
}
