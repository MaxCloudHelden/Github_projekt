# GitHub Organisation mit Terraform verwalten

Willkommen! Dieses Repository hilft dir dabei, deine GitHub Organisation automatisch zu verwalten - ohne alles manuell klicken zu müssen.

## Was macht dieses Projekt?

Mit diesem Terraform-Projekt kannst du automatisch:

- Benutzer zu deiner GitHub Organisation einladen
- Teams erstellen und verwalten
- Repositories anlegen
- Dateien (README, Dockerfile, .gitignore) in Repositories erstellen
- Team-Zugriffsrechte auf Repositories vergeben

Alles durch einfache Konfigurationsdateien - keine manuellen Klicks mehr!

## Was ist Terraform?

Terraform ist ein Tool, mit dem du Infrastruktur als Code verwalten kannst. Statt manuell Einstellungen in GitHub vorzunehmen, schreibst du eine Konfiguration und Terraform setzt sie automatisch um.

**Vorteile:**
- Wiederholbar - einmal konfiguriert, beliebig oft ausführbar
- Versionierbar - alle Änderungen sind in Git nachvollziehbar
- Dokumentiert - die Konfiguration ist gleichzeitig die Dokumentation

## Projektstruktur

Providers.tf
 -> Alle Infos zum Github Provider mit Konfiguration
 Members.tf
 --> Alle Infos zur Verrechtung
 Main.tf
 --> Alle Infos zum erstellten Repo und desen Inhalte
 Variables.tf
 --> Definition der genutzten Variablen
 terraform.tfvars
--> Hinterlegte Werte für die jeweiligen Variablen


## Voraussetzungen

Du benötigst:

1. **GitHub Account** mit Zugriff auf eine Organisation
2. **GitHub Personal Access Token** (wie man den erstellt, siehe unten)
3. **GitHub Codespace**

## Schritt-für-Schritt Anleitung

### Schritt 1: GitHub Personal Access Token erstellen

Ein Token ist wie ein Passwort, mit dem Terraform auf deine GitHub Organisation zugreifen kann.

1. Gehe zu GitHub und klicke auf dein Profilbild (oben rechts)
2. Klicke auf **Settings**
3. Scrolle ganz nach unten zu **Developer settings**
4. Klicke auf **Personal access tokens** → **Tokens (classic)**
5. Klicke auf **Generate new token (classic)**
6. Gib dem Token einen Namen, z.B. "Terraform"
7. Wähle folgende Berechtigungen aus:
   - `repo` (alle Unteroptionen aktivieren)
   - `admin:org` (alle Unteroptionen aktivieren)
8. Klicke auf **Generate token**
9. **WICHTIG:** Kopiere den Token sofort! Er wird nur einmal angezeigt!

### Schritt 2: Organisation finden

Du benötigst den Namen deiner GitHub Organisation:

1. Gehe zu github.com
2. Klicke auf dein Profilbild → **Your organizations**
3. Kopiere den Namen deiner Organisation (steht unter dem Logo)

### Schritt 3: Repository klonen

Öffne ein Terminal (oder GitHub Codespace) und führe aus:

```bash
git clone https://github.com/MaxCloudHelden/Github_projekt.git
cd Github_projekt
```

### Schritt 4: Konfigurationsdatei erstellen

Erstelle eine neue Datei namens `terraform.tfvars`:

```bash
nano terraform.tfvars
```

Füge folgende Zeilen ein (ersetze die Werte mit deinen eigenen):

```hcl
github_token        = "ghp_deinTokenHierEinfuegen"
github_organization = "DeinOrganisationsName"
user1_username      = "githubusername1"
user2_username      = "githubusername2"
repository_name     = "mein-test-repo"
```

**Beispiel:**
```hcl
github_token        = "ghp_abc123XYZ..."
github_organization = "MeineFirma"
user1_username      = "maxmustermann"
user2_username      = "erikameier"
repository_name     = "docker-demo"
```

Speichere die Datei (Ctrl+O, Enter, Ctrl+X bei nano).

**WICHTIG:** Diese Datei enthält sensible Daten und wird NICHT ins Git hochgeladen (steht in .gitignore)!

### Schritt 5: Terraform initialisieren

Terraform muss einmalig vorbereitet werden:

```bash
terraform init
```

Das lädt alle benötigten Module herunter. Du siehst grünen Text, wenn alles geklappt hat.

### Schritt 6: Vorschau anzeigen

Bevor etwas erstellt wird, kannst du dir ansehen, was passieren würde:

```bash
terraform plan
```

Du siehst eine Liste mit:
- Grünen `+` Zeichen = wird neu erstellt
- Gelben `~` Zeichen = wird geändert
- Roten `-` Zeichen = wird gelöscht

**Beispiel-Ausgabe:**
```
Plan: 7 to add, 0 to change, 0 to destroy.
```

Das bedeutet: 7 Ressourcen werden erstellt.

### Schritt 7: Änderungen anwenden

Jetzt wird es ernst! Führe aus:

```bash
terraform apply
```

Terraform zeigt dir nochmal, was passieren wird, und fragt:

```
Do you want to perform these actions?
Enter a value: 
```

Tippe `yes` und drücke Enter.

Terraform erstellt jetzt:
1. Ein Team namens "Entwicklung"
2. Lädt User1 zur Organisation ein
3. Fügt User2 zum Team hinzu
4. Erstellt ein neues Repository
5. Fügt README.md, Dockerfile und .gitignore zum Repository hinzu
6. Gibt dem Team Zugriff auf das Repository

### Schritt 8: Ergebnis prüfen

Nach erfolgreicher Ausführung kannst du auf GitHub nachsehen:

1. Gehe zu deiner Organisation auf GitHub
2. Unter **Teams** siehst du das Team "Entwicklung"
3. Unter **Repositories** siehst du das neue Repository
4. Die eingeladenen Benutzer erhalten eine E-Mail

Du kannst auch die Terraform Outputs anzeigen:

```bash
terraform output
```

## Was wird erstellt?

### 1. Team "Entwicklung"
- Ein geschlossenes Team in deiner Organisation
- User2 wird automatisch Mitglied

### 2. Organisations-Mitgliedschaft
- User1 wird als "Member" zur Organisation eingeladen
- Erhält eine E-Mail-Einladung

### 3. Repository
- Name: wie in `terraform.tfvars` definiert
- Typ: Private
- Enthält Issues, Projects, Wiki
- Bereits initialisiert mit main Branch

### 4. Repository-Dateien
- **README.md** - Anleitung für Docker
- **Dockerfile** - Einfacher Nginx Webserver
- **.gitignore** - Ignoriert sensible und unnötige Dateien

### 5. Team-Zugriff
- Team "Entwicklung" erhält Push-Rechte auf das Repository
- Mitglieder können Code schreiben und pushen

## Änderungen vornehmen

### Einen weiteren Benutzer hinzufügen

1. Öffne `members.tf`
2. Füge am Ende hinzu:

```hcl
resource "github_membership" "user3" {
  username = "neuerbenutzer"
  role     = "member"
}
```

3. Führe aus:
```bash
terraform apply
```

### Repository-Name ändern

1. Öffne `terraform.tfvars`
2. Ändere `repository_name = "neuer-name"`
3. Führe aus:
```bash
terraform apply
```


## Sicherheitstipps

1. **NIEMALS** `terraform.tfvars` ins Git hochladen!
2. **NIEMALS** deinen Token teilen oder öffentlich posten
3. Rotiere (erneuere) deinen Token regelmäßig (z.B. alle 3 Monate)
4. Gib dem Token nur die minimal nötigen Berechtigungen
5. Lösche alte Tokens, die du nicht mehr brauchst

## Hilfe bekommen

Falls du nicht weiterkommst:

1. Lies die Fehlermeldung genau - sie enthält oft die Lösung
2. Führe `terraform validate` aus, um Syntaxfehler zu finden
3. Prüfe deine `terraform.tfvars` auf Tippfehler
4. Schaue in die Terraform Dokumentation
5. Frage im Team oder in Terraform Communities

## Nächste Schritte

Wenn du dieses Projekt erfolgreich eingerichtet hast, kannst du:

- Weitere Repositories automatisch erstellen
- Mehr Teams und Mitglieder verwalten
