module "shared_vpc" {
  source          = "github.com/XBankGCPOrg/gcp-lz-products//shared-vpc?ref=df4d71b7e32e589b7904408949043f128177a572"
  project_vending = yamldecode(file("${path.module}/config.yaml"))
}