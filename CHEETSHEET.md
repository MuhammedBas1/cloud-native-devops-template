# Mein DevOps Cheatsheet (cloud-native-devops-template)

## Terminal-Basics
- `mkdir ordner` -> Ordner erstellen
- `cd ordner` -> hineingehen | `cd ..` -> eine Ebene hoch
- `code .` -> aktuellen Ordner in VS Code oeffnen (Punkt = aktueller Ordner!)

## Git lokal
- `git init` -> Ordner zum Git-Repo machen (erstellt .git/)
- `git status` -> Zustand zeigen (untracked / staged / modified)
- `git add DATEI` -> Datei in die Staging Area ("Koffer") packen
- `git commit -m "Nachricht"` -> Snapshot mit Notiz speichern
- `git branch -m alt neu` -> Branch umbenennen (-m = move/rename)

## Git mit GitHub
- `git remote add origin URL` -> GitHub-Adresse unter Spitzname "origin" merken
- `git push -u origin main` -> erster Push + Verbindung merken (-u = upstream)
- `git push` -> jeder weitere Push (Kurzform dank -u)

## Docker
- `docker build -t name:tag .` -> Image aus Dockerfile bauen (Punkt = Build Context!)
- `docker run -d -p 8080:80 --name x image:tag` -> Container starten
  - `-d` = Hintergrund | `-p` = Host:Container-Port | `--name` = CONTAINER-Name
- `docker stop NAME` -> Container stoppen (macht Port frei)
- `docker ps` -> laufende Container anzeigen

## Docker Compose (docker-compose.yml)
- `docker compose up -d` -> alle Services bauen + starten (Hintergrund)
- `docker compose down` -> alle Services stoppen + entfernen
- EXPOSE = nur Doku! Erst ports:/-p veroeffentlicht wirklich.

## GitHub Actions (.github/workflows/ci.yml)
- Trigger: on > push > branches: [main]
- runs-on: ubuntu-latest = frische GitHub-VM (Runner, Docker vorinstalliert)
- uses: actions/checkout@v5 = Code auf den leeren Runner laden
- run: = ganz normaler Terminal-Befehl

## Konzepte (Interview-Wissen!)
- Image = Bauplan | Container = laufende Instanz
- Staging Area = Koffer fuer den naechsten Commit
- Bind Mount = echter PC-Ordner | Named Volume = Docker-verwalteter Datenspeicher
- Build Context = der Ordner, den Docker zum Bauen geschickt bekommt

## Meine Schmerzpunkte (Lessons Learned)
- YAML: Einrueckung mit LEERZEICHEN, nie Tabs; Einstellungen 2 Ebenen tiefer als der Name
- Workflow-Trigger [main] vs. Branch master -> "no workflows"-Fehler
- Node-20-Warnung -> actions/checkout@v5 statt @v4 nutzen