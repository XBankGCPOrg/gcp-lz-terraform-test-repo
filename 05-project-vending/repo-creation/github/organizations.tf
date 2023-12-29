locals {
  org_data = yamldecode(file("${path.module}/project_vending.yaml"))
}

# resource "github_membership" "default" {
#   for_each = var.org_member_invitation != null ? var.org_member_invitation : {}
#   username = each.key
#   role     = each.value.role
# }

# resource "github_membership" "default" {
#   username = "narayan-khanna"
#   role     = "admin"
# }

resource "github_repository_collaborator" "default" {
  for_each   = local.org_data.repositories
  repository = github_repository.default[each.key].name
  username   = var.github_username
  permission = "admin"
}


resource "github_team_repository" "default" {
  for_each   = local.org_data.repositories == null ? {} : local.org_data.repositories
  team_id    = data.github_team.default[local.org_data.teams[each.key].parent_team_name].id
  repository = github_repository.default[each.key].name
  permission = each.value.permission
  depends_on = [github_repository.default]
}

# data "github_team" "default" {
#   for_each = {
#     for key, value in local.org_data.teams : key => value
#     if lookup(value, "parent_team_name", null) != null
#   }
#   slug = each.value.parent_team_name
# }

data "github_team" "default" {
  for_each = {
    for key, value in local.org_data.teams : value.parent_team_name => key
    if lookup(value, "parent_team_name", null) != null
  }
  slug = each.key
}