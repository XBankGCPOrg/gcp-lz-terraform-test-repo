# data "github_team" "default" {
#   for_each = {
#     for key, value in var.teams : key => value
#     if lookup(value, "parent_team_name", null) != null
#   }
#   slug = each.value.parent_team_name
# }

# resource "github_team" "default" {
#   for_each       = var.teams != null ? var.teams : {}
#   name           = each.key
#   privacy        = each.value.privacy
#   description    = each.value.description
#   parent_team_id = each.value.parent_team_name == null ? null : data.github_team.default[each.key].id
# }

# resource "github_team_membership" "default" {
#   for_each = var.team_members != null ? var.team_members : {}
#   team_id  = github_team.default[each.value.team].id
#   username = each.key
#   role     = each.value.role

#   depends_on = [github_membership.default]
# }
