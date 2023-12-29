terraform {
  backend "gcs" {
    bucket = "bkt-prj-lz-seed-t99o-tfstate-foundation"
    prefix = "terraform/foundation/platformtools/state"
  }
}
