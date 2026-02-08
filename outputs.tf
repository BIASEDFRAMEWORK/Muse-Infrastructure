output "repository_full_name" {
  value       = github_repository.app_repo.full_name
  description = "Full name of the managed repository."
}
