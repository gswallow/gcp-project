variable "billing_account_id" {
  description = "The ID of the billing account to attach to each project"
  type        = string
}

variable "folder_name" {
  description = "The name of the folder to create"
  type        = string
}

variable "org_name" {
  description = "The parent organization of the folder"
  type        = string
}

variable "project_name" {
  description = "The name of the project to create in the folder"
  type        = string
}

variable "project_users" {
  description = "List of users to add to the project"
  type        = list(string)
  default     = []
}

variable "enabled_apis" {
  description = "List of APIs to enable for the project"
  type        = list(string)
  default     = []
}

variable "auto_create_network" {
  description = "Create a default network for the project"
  type        = bool
  default     = false
}

variable "default_enabled_apis" {
  description = "A default set of APIs to enable"
  type        = list(string)
  default = [
    "compute.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "storage-component.googleapis.com",
    "storagetransfer.googleapis.com",
    "servicenetworking.googleapis.com",
    "firewallinsights.googleapis.com",
    "domains.googleapis.com",
    "dns.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "cloudtrace.googleapis.com",
    "clouderrorreporting.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "containerscanning.googleapis.com",
    "containerthreatdetection.googleapis.com",
    "sql-component.googleapis.com"
  ]
}

variable "labels" {
  description = "Extra tags to apply to created resources"
  type        = map(string)
  default     = {}
}

locals {
  enabled_apis = length(var.enabled_apis) == 0 ? var.default_enabled_apis : var.enabled_apis
  labels = merge({
    OrganizationId = var.org_name
    BillingAccount = var.billing_account_id
  }, var.labels)
}
