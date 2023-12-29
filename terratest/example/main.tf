locals {
  filenames = fileset("${path.module}/policies", "**")

  policies = flatten([for filename in local.filenames : yamldecode(file("${path.module}/policies/${filename}"))])
}



module "test" {
  source               = "github.com/XBankGCPOrg/gcp-lz-products//management?ref=main"
  domain               = "psxbank.gcp-foundation.com"
  billing_account      = "01EBA6-74BB59-078C79"
  location             = "europe-west2"
  foundation_hierarchy = yamldecode(file("${path.module}/foundation.yaml"))
  iam_policy           = yamldecode(file("${path.module}/iam_role_binding.yaml"))
  org_policy           = yamldecode(file("${path.module}/org_policy.yaml"))
  deny_policies        = local.policies
  project_billing      = "prj-c-bill"
  project_guardrails   = "prj-c-sec"
  project_logging      = "prj-c-log"
  test_flag                 = true 
}





