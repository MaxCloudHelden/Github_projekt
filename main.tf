# Repository erstellen
resource "github_repository" "erstesRepo" {
  name        = var.repository_name
  description = "Demo Repository mit Dockerfile und Anleitung"
  visibility  = "private"
  
  has_issues      = true
  has_projects    = true
  has_wiki        = true
  has_downloads   = true
  auto_init       = true
}

# Team Zugriff auf Repository geben
resource "github_team_repository" "entwicklung_repo_access" {
  team_id    = github_team.entwicklung-team.id
  repository = github_repository.erstesRepo.name
  permission = "push"
}

# README.md Datei erstellen
resource "github_repository_file" "readme" {
  repository          = github_repository.erstesRepo.name
  branch              = "main"
  file                = "README.md"
  content             = <<-EOT
# Docker Demo App

Dieses Repository enthält eine einfache Demo-Anwendung mit einem Dockerfile.

## Voraussetzungen

- Docker ist in CodeSpaces installiert
- Grundkenntnisse der Kommandozeile

## Docker Image bauen

Um aus dem Dockerfile ein Docker Image zu erstellen, führen Sie folgenden Befehl im Repository-Verzeichnis aus:
bash
docker build -t meine-demo-app:latest
EOT
  commit_message      = "Initial commit: README hinzugefügt"
  commit_author       = "Ihr"
  commit_email        = "ihr@ihr.de"
  overwrite_on_create = true
}

# Dockerfile erstellen
resource "github_repository_file" "dockerfile" {
  repository          = github_repository.erstesRepo.name
  branch              = "main"
  file                = "Dockerfile"
  content             = <<-EOT
FROM nginx:alpine

EXPOSE 80
  EOT
  commit_message      = "Initial commit: Dockerfile hinzugefügt"
  commit_author       = "Ihr"
  commit_email        = "ihr@ihr.de"
  overwrite_on_create = true
  
  depends_on = [github_repository_file.readme]
}

resource "github_repository_file" "gitignore" {
  repository          = github_repository.erstesRepo.name
  branch              = "main"
  file                = ".gitignore"
  content             = <<-EOT
node_modules/
__pycache__/
.vscode/
.idea/
.DS_Store
*.log
.env
*.tfvars
EOT
  commit_message      = "Initial commit: .gitignore hinzugefügt"
  commit_author       = "Ihr"
  commit_email        = "ihr@ihr.de"
  overwrite_on_create = true
  
  depends_on = [github_repository_file.dockerfile]
}