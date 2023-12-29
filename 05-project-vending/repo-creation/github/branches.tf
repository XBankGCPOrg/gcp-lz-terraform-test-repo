locals {
  branches = yamldecode(file("${path.module}/project_vending.yaml"))
}

resource "github_branch" "default" {
  for_each   = local.branches.repositories != null ? local.yaml_data.repositories : {}
  repository = github_repository.default[each.key].name
  branch     = each.value.default_branch
}

resource "github_branch_default" "default" {
  for_each   = local.branches.repositories
  repository = github_repository.default[each.key].name
  branch     = each.value.default_branch
  depends_on = [github_branch.default]
}
