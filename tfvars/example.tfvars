org_domain = "gregongcp.net"
folders = [ 
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

projects = [
  {
    folder_name = "non-prod",
    project_name = "ops",
    identifier = "non-prod-ops",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "user:devopsgal@gregongcp.net",
      "user:devopsguy@gregongcp.net"
    ]
  },
  {
    folder_name = "non-prod",
    project_name = "dev",
    identifier = "non-prod-dev",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "user:devopsgal@gregongcp.net",
      "user:devopsguy@gregongcp.net"
    ]
  },
  {
    folder_name = "non-prod",
    project_name = "qa",
    identifier = "non-prod-qa",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "user:devopsgal@gregongcp.net",
      "user:devopsguy@gregongcp.net"
    ]
  },
  {
    folder_name = "non-prod",
    project_name = "uat",
    identifier = "non-prod-uat",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "user:devopsgal@gregongcp.net",
      "user:devopsguy@gregongcp.net"
    ]
  },
  {
    folder_name = "prod",
    project_name = "ops",
    identifier = "prod-ops",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "user:sre@gregongcp.net"
    ]
  },
  {
    folder_name = "prod",
    project_name = "prod",
    identifier = "prod-prod",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "user:sre@gregongcp.net"
    ]
  }
]

networks = [
  {
    name = "non-prod",
    host_project_identifier = "non-prod-ops",
    parent_folder_name = "non-prod",
    auto_create_networks = false,
    routing_mode = "REGIONAL",
    delete_default_routes_on_create = true,
    cidr_block = "10.240.0.0/16",
    gcp_regions = [ "us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4" ],
    subnet_cidr_suffix = 20
  },
  {
    name = "prod",
    host_project_identifier = "prod-ops",
    parent_folder_name = "prod",
    auto_create_networks = false,
    routing_mode = "REGIONAL",
    delete_default_routes_on_create = true, cidr_block = "10.248.0.0/16",
    gcp_regions = [ "us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4" ],
    subnet_cidr_suffix = 20
  }
]
