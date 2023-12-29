output "repo_names" {
  value = [for repo in github_repository.default : repo.name]
}