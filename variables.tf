variable "gcp_region" {
  description = "The Google Cloud region in which to create resources"
  type        = string
  default     = "us-central1"
}

variable "org_domain" {
  description = "The organization in charge of created resources"
  type        = string
  default     = "Group1001"
}

variable "billing_account_id" {
  description = "The ID of hte billing account with which to associate this project"
  type        = string
}

variable "folder_name" {
  description = "The name of a folder to create for Google Projects"
  type        = string
  default     = "default"
}

variable "budget_amount" {
  description = "The amount of money to use for a budget alert"
  type        = number
  default     = 10
}

variable "project_name" {
  description = "The name of the project to create"
  type        = string
}

variable "enabled_apis" {
  description = "The list of APIs to enable for the project"
  type        = list(string)
  default = [
    "compute.googleapis.com", "replicapool.googleapis.com", "replicapoolupdater.googleapis.com", "resourceviews.googleapis.com",
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
  labels = merge({
    OrganizationId = var.org_domain
    BillingAccount = var.billing_account_id
    Folder         = var.folder_name
    Project        = var.project_name
  }, var.labels)
}
