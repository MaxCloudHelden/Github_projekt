# User1 als Member zur Organisation einladen
resource "github_membership" "user1" {
  username = var.user1_username
  role     = "member"
}

# Team "Entwicklung" erstellen
resource "github_team" "entwicklung-team" {
  name        = "Entwicklung"
  description = "Team für Entwickler"
  privacy     = "closed"
}

# User2 zum Team "Entwicklung" hinzufügen
resource "github_team_membership" "user2_entwicklung" {
  team_id  = github_team.entwicklung-team.id
  username = var.user2_username
  role     = "member"
}