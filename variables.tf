
variable "github_token" {
  description = "PAT Token für die Github CLI"
  type        = string
  sensitive   = true
}

variable "github_organization" {
  description = "Name der Organization"
  type        = string
  sensitive   = true
}

variable "user1_username" {
  description = "Name des 1. Users für die Organization"
  type        = string
  sensitive   = true
}

variable "user2_username" {
  description = "Name des 2. Users für das Team"
  type        = string
  sensitive   = true
}

variable "repository_name" {
  description = "Name des 1. Test-Repos"
  type        = string
  sensitive   = true
}