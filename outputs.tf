output "google_org_id" {
  value = data.google_organization.org.org_id
}

output "billing_account_id" {
  value = data.google_billing_account.acct.id
}

output "billing_account_name" {
  value = data.google_billing_account.acct.name
}

output "billing_account_project_ids" {
  value = data.google_billing_account.acct.project_ids
}

output "client_config_project" {
  value = data.google_client_config.client.project
}

output "client_config_region" {
  value = data.google_client_config.client.region
}

output "client_config_zone" {
  value = data.google_client_config.client.zone
}

output "client_openid_userinfo" {
  value = data.google_client_openid_userinfo.client.email
}

output "vpc_service_projects" {
  value = module.google_network["non-prod"].service_projects
}
