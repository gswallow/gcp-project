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
