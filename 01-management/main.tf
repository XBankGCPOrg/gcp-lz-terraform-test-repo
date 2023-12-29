locals {
  filenames = fileset("${path.module}/policies", "**")

  policies = flatten([for filename in local.filenames : yamldecode(file("${path.module}/policies/${filename}"))])

}

module "management" {
  source               = "github.com/XBankGCPOrg/gcp-lz-products//management?ref=main"
  domain               = "psxbank.gcp-foundation.com"
  billing_account      = "01EBA6-74BB59-078C79"
  location             = "europe-west2"
  foundation_hierarchy = yamldecode(file("${path.module}/foundation.yaml"))
  iam_policy           = yamldecode(file("${path.module}/iam_role_binding.yaml"))
  org_policy           = yamldecode(file("${path.module}/org_policy.yaml"))
  deny_policies        = local.policies
  project_billing      = "prj-c-billing"
  project_guardrails   = "prj-c-security"
  project_logging      = "prj-c-logging"
  budget_config        = yamldecode(file("${path.module}/budgets_config.yaml")).budget_config
  monitoring_config    = yamldecode(file("${path.module}/monitoring_config.yaml")).monitoring_config


}