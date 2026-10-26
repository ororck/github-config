output "name" {
  description = "Repository name"
  value       = github_repository.this.name
}

output "html_url" {
  description = "Repository URL"
  value       = github_repository.this.html_url
}

output "ssh_clone_url" {
  description = "SSH clone URL"
  value       = github_repository.this.ssh_clone_url
}
