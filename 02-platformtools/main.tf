module "platform" {
  source            = "github.com/XBankGCPOrg/gcp-lz-products//platform-tools?ref=main"
  domain            = "psxbank.gcp-foundation.com"
  centralized_kms   = yamldecode(file("${path.module}/kms_artifact_registry_config.yaml")).centralized_kms
  artifact_registry = yamldecode(file("${path.module}/kms_artifact_registry_config.yaml")).artifact_registry
}