variable "name" {
  description = "The name of the network to create"
  type        = string
}

variable "project_id" {
  description = "The project in which to create the network"
  type        = string
}

variable "parent_folder_name" {
  description = "The folder in which to search for service projects"
  type        = string
}

variable "number_of_service_projects" {
  description = "The number of service projects that will be linked to the shared VPC"
  type        = number
}

variable "auto_create_subnets" {
  description = "Whether to automatically create subnets"
  type        = bool
  default     = false
}

variable "routing_mode" {
  description = "Whether to advertise route GLOBALly or REGIONALly"
  type        = string
  default     = "REGIONAL"
}

variable "delete_default_routes_on_create" {
  description = "Whether to delete default routes after creating a network"
  type        = bool
  default     = true
}

variable "gcp_regions" {
  description = "The regions that will host a subnet in the VPC"
  type        = list(string)
  default     = ["us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4"]
}

variable "cidr_block" {
  description = "The CIDR block of the VPC network to create"
  type        = string
  default     = "10.100.0.0/16"
}

variable "subnet_cidr_suffix" {
  description = "The CIDR suffix of each subnet in the VPC (e.g. /20)"
  type        = number
  default     = 20
}

variable "service_project_service_accounts" {
  description = "The list of service accounts to grant compute.networkUser to"
  type        = list(string)
  default     = []
}

locals {
  new_bits = var.subnet_cidr_suffix - tonumber(trimprefix(regex("/[0-9]+$", var.cidr_block), "/"))
}
