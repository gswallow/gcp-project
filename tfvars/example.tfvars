parent_id = "customers/C02xxxxxx"
org_domain = "gregongcp.net"
terraform_service_account = "terraform@np-ops-12324567890.iam.gserviceaccount.com"
project_id = np-ops-1234567890
create_groups = true

folders = [ 
  { name = "non-prod" },
  { name = "prod" }
]

projects = [
  {
    folder_name = "non-prod",
    project_name = "np-ops",
    identifier = "non-prod-ops",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    service_account_elevated_privileges = true,
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "group:devops@gregongcp.net",
      "group:sre@gregongcp.net"
    ]
  },
  {
    folder_name = "non-prod",
    project_name = "np-dev",
    identifier = "non-prod-dev",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    service_account_elevated_privileges = false,
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "group:devops@gregongcp.net",
      "group:sre@gregongcp.net"
    ]
  },
  {
    folder_name = "non-prod",
    project_name = "np-qa",
    identifier = "non-prod-qa",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    service_account_elevated_privileges = false,
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "group:devops@gregongcp.net",
      "group:sre@gregongcp.net"
    ]
  },
  {
    folder_name = "non-prod",
    project_name = "np-uat",
    identifier = "non-prod-uat",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    service_account_elevated_privileges = false,
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "group:devops@gregongcp.net",
      "group:sre@gregongcp.net"
    ]
  },
  {
    folder_name = "prod",
    project_name = "p-ops",
    identifier = "prod-ops",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    service_account_elevated_privileges = false,
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "group:sre@gregongcp.net"
    ]
  },
  {
    folder_name = "prod",
    project_name = "p-prod",
    identifier = "prod-prod",
    enabled_apis = [],
    auto_create_network = false,
    role_bindings = [],
    service_account_elevated_privileges = false,
    terraform_impersonators = [
      "user:admin@gregongcp.net",
      "group:sre@gregongcp.net"
    ]
  }
]

networks = [
  {
    name = "non-prod",
    host_project_identifier = "non-prod-ops",
    parent_folder_name = "non-prod",
    auto_create_subnets = false,
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
    auto_create_subnets = false,
    routing_mode = "REGIONAL",
    delete_default_routes_on_create = true, cidr_block = "10.248.0.0/16",
    gcp_regions = [ "us-central1", "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4" ],
    subnet_cidr_suffix = 20
  }
]

groups = [
  {
    display_name = "qa",
    description = "Example QA Team",
    permissions = [{
      project_id  = "non-prod-uat",
      project_roles = [
        "roles/container.clusterViewer",
        "roles/cloudtrace.user"
      ]
    },
    {
      project_id = "non-prod-qa",
      project_roles = [
        "roles/container.clusterViewer",
        "roles/cloudtrace.user"
      ]
    },
    {
      project_id = "non-prod-dev",
      project_roles = [
        "roles/container.clusterViewer",
        "roles/cloudtrace.user"
      ]
    }]
  }
]
