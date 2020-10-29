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
  type        = list(object({ name = string, viewers = list(string) }))
  default = [
    {
      name = "non-prod",
      viewers = [
        "user:devopsgal@gregongcp.net",
        "user:devopsguy@gregongcp.net",
        "user:sre@gregongcp.net",
        "user:support@gregongcp.net"
      ]
    },
    {
      name = "prod",
      viewers = [
        "user:sre@gregongcp.net",
        "user:support@gregongcp.net"
      ]
    }
  ]
}

variable "projects" {
  description = "A list of objects including folder names, projects, and IAM principals"
  type        = list(object({ folder_name = string, project_name = string, identifier = string, enabled_apis = list(string), auto_create_network = bool, role_bindings = list(string), terraform_impersonators = list(string) }))
  default = [
    {
      folder_name         = "non-prod",
      project_name        = "ops",
      identifier          = "non-prod-ops",
      enabled_apis        = [],
      auto_create_network = false,
      role_bindings       = []
      terraform_impersonators = [
        "user:admin@gregongcp.net",
        "user:devopsgal@gregongcp.net",
        "user:devopsguy@gregongcp.net"
      ]
    },
    {
      folder_name         = "non-prod",
      project_name        = "dev",
      identifier          = "non-prod-dev",
      enabled_apis        = [],
      auto_create_network = false,
      role_bindings       = []
      terraform_impersonators = [
        "user:admin@gregongcp.net",
        "user:devopsgal@gregongcp.net",
        "user:devopsguy@gregongcp.net"
      ]
    },
    {
      folder_name         = "non-prod",
      project_name        = "qa",
      identifier          = "non-prod-qa",
      enabled_apis        = [],
      auto_create_network = false,
      role_bindings       = []
      terraform_impersonators = [
        "user:admin@gregongcp.net",
        "user:devopsgal@gregongcp.net",
        "user:devopsguy@gregongcp.net"
      ]
    },
    { folder_name         = "non-prod",
      project_name        = "uat",
      identifier          = "non-prod-uat",
      enabled_apis        = [],
      auto_create_network = false,
      role_bindings       = []
      terraform_impersonators = [
        "user:admin@gregongcp.net",
        "user:devopsgal@gregongcp.net",
        "user:devopsguy@gregongcp.net"
      ]
    },
    {
      folder_name         = "prod",
      project_name        = "ops",
      identifier          = "prod-ops",
      enabled_apis        = [],
      auto_create_network = false,
      role_bindings       = []
      terraform_impersonators = [
        "user:sre@gregongcp.net",
        "user:admin@gregongcp.net"
      ]
    },
    {
      folder_name         = "prod",
      project_name        = "prod",
      identifier          = "prod-prod",
      enabled_apis        = [],
      auto_create_network = false,
      role_bindings       = []
      terraform_impersonators = [
        "user:sre@gregongcp.net",
        "user:admin@gregongcp.net"
      ]
    }
  ]
}

variable "networks" {
  description = "A list of shared VPC networks to create"
  type        = list(object({ name = string, host_project_identifier = string, parent_folder_name = string, auto_create_networks = bool, routing_mode = string, delete_default_routes_on_create = string, cidr_block = string, gcp_regions = list(string), subnet_cidr_suffix = number }))
  default = [
    {
      name                            = "non-prod",
      host_project_identifier         = "non-prod-ops",
      parent_folder_name              = "non-prod",
      auto_create_networks            = false,
      routing_mode                    = "REGIONAL",
      delete_default_routes_on_create = true,
      cidr_block                      = "10.240.0.0/16",
      gcp_regions                     = ["us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4"],
      subnet_cidr_suffix              = 20
    },
    {
      name                            = "prod",
      host_project_identifier         = "prod-ops",
      parent_folder_name              = "prod",
      auto_create_networks            = false,
      routing_mode                    = "REGIONAL",
      delete_default_routes_on_create = true,
      cidr_block                      = "10.248.0.0/16",
      gcp_regions                     = ["us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4"],
      subnet_cidr_suffix              = 20
    }
  ]
}

variable "labels" {
  description = "Extra tags to apply to created resources"
  type        = map(string)
  default     = {}
}

locals {
  labels = merge(
    {
      OrganizationId = var.org_domain 
      BillingAccount = var.billing_account_id 
    },
    var.labels)
  }
