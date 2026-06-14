# Nutzen des offiziellen Python Alpine-Images für ein schlankes Container-Abbild
FROM python:3.11-slim

# Arbeitsverzeichnis im Container festlegen
WORKDIR /app

# System-Abhängigkeiten installieren, die eventuell für SQLite oder Python-Pakete gebraucht werden
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Zuerst die requirements.txt kopieren (nutzt Docker-Caching für schnellere Builds)
COPY requirements.txt .

# Python-Abhängigkeiten installieren
RUN pip install --no-cache-dir -r requirements.txt

# Den restlichen Quellcode der App in den Container kopieren
COPY . .

# Den Port verpassen, auf dem die App standardmäßig läuft (laut deiner Readme Port 5000)
EXPOSE 5000

# Startbefehl für die Anwendung
CMD ["python", "-m", "api.app"]