locals {
  yaml_data = yamldecode(file("${path.module}/project_vending.yaml"))
}

resource "github_repository" "default" {
  for_each                                = local.yaml_data.repositories != null ? local.yaml_data.repositories : {}
  name                                    = each.key
  visibility                              = each.value.visibility
  description                             = each.value.description
  auto_init                               = each.value.auto_init
  homepage_url                            = each.value.homepage_url
  has_projects                            = each.value.has_projects
  has_issues                              = each.value.has_issues
  has_wiki                                = each.value.has_wiki
  is_template                             = each.value.is_template
  allow_merge_commit                      = each.value.allow_merge_commit
  allow_squash_merge                      = each.value.allow_squash_merge
  allow_rebase_merge                      = each.value.allow_rebase_merge
  allow_auto_merge                        = each.value.allow_auto_merge
  delete_branch_on_merge                  = each.value.delete_branch_on_merge
  has_downloads                           = each.value.has_downloads
  gitignore_template                      = each.value.gitignore_template
  license_template                        = each.value.license_template
  archived                                = each.value.archived
  archive_on_destroy                      = each.value.archived_on_destroy
  topics                                  = each.value.topics
  vulnerability_alerts                    = each.value.vulnerability_alert
  ignore_vulnerability_alerts_during_read = each.value.ignore_vulnerability_alerts_during_read
  default_branch                          = each.value.default_branch

  # dynamic "pages" {
  #   for_each = each.value.pages == null ? [] : each.value.pages
  #   content {
  #     cname = pages.value["cname"]

  #     dynamic "source" {
  #       for_each = pages.value.source
  #       content {
  #         branch = source.value["branch"]
  #         path   = source.value["path"]
  #       }
  #     }
  #   }
  # }

  dynamic "template" {
    for_each = each.value.template == null ? [] : each.value.template
    content {
      owner      = template.value["owner"]
      repository = template.value["repository"]
    }
  }
}



provider "github" {
  token = var.github_pat_token
  owner = "XBankGCPOrg"
}


