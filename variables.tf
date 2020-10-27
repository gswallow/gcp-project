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
  description = "The ID of the billing account with which to associate this project"
  type        = string
}

variable "budget_amount" {
  description = "The amount of money to use for a budget alert"
  type        = number
  default     = 10
}

variable "folders" {
  description = "A list of folders to create"
  type        = list(object({ name = string, editors = list(string), viewers = list(string) }))
  default     = [
    {
      name = "non-prod",
      editors = [
        "user:noah@theoperatorisdrunk.com",
        "user:nami@theoperatorisdrunk.com"
      ],
      viewers = [
        "user:madeline@theoperatorisdrunk.com"
      ]
    },
    {
      name = "prod",
      editors = [
      ],
      viewers = [
        "user:noah@theoperatorisdrunk.com",
        "user:nami@theoperatorisdrunk.com",
        "user:madeline@theoperatorisdrunk.com"
      ]
    }
  ]
}

variable "projects" {
  description = "A list of objects including folder names, projects, and IAM principals"
  type        = list(object({ folder_name = string, project_name = string, project_users = list(string), enabled_apis = list(string) }))
  default = [
    {
      folder_name   = "non-prod",
      project_name  = "dev",
      project_users = ["greg@theoperatorisdrunk.com"],
      enabled_apis  = []
    },
    {
      folder_name   = "non-prod",
      project_name  = "qa",
      project_users = ["greg@theoperatorisdrunk.com"],
      enabled_apis  = []
    },
    {
      folder_name   = "non-prod",
      project_name  = "uat",
      project_users = ["greg@theoperatorisdrunk.com"],
      enabled_apis  = []
    },
    {
      folder_name   = "prod",
      project_name  = "prod",
      project_users = ["greg@theoperatorisdrunk.com"],
      enabled_apis  = []
    }
  ]
}

variable "default_enabled_apis" {
  description = "The default list of APIs to enable for each project"
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
  labels = merge({
    OrganizationId = var.org_domain
    BillingAccount = var.billing_account_id
  }, var.labels)
}
