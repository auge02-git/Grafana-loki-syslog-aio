# Grafana Loki Syslog All-In-One (AIO)

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Grafana](https://img.shields.io/badge/Grafana-11.x-orange?logo=grafana)](https://grafana.com/)
[![Loki](https://img.shields.io/badge/Loki-3.x-blue?logo=grafana)](https://grafana.com/oss/loki/)

Dieses Projekt bietet einen vorkonfigurierten Stack, um schnell mit einem Syslog-Ingestor und der Visualisierung von Logs zu starten. Es nutzt **Grafana Loki** als Speicher und **Grafana Alloy** (Nachfolger von Promtail) als Receiver für weitergeleitete Logs von **syslog-ng**.

![Loki Syslog AIO Overview](loki_syslog_aio.png)

## 🚀 Über das Projekt

Dieses Setup ist darauf ausgelegt, Netzwerk-Traffic von Legacy-Systemen (RFC3164 via UDP 2514) effizient in Loki zu überführen.

### Der Stack im Überblick:
*   **Visualisierung:** Grafana
*   **Log-Aggregation:** Grafana Loki (mit MinIO S3 oder Filesystem Storage)
*   **Collector/Pipeline:** Grafana Alloy (empfohlen) oder Promtail (legacy)
*   **Syslog-Relay:** syslog-ng
*   **Monitoring:** Prometheus, Alertmanager, Blackbox-Exporter
*   **Tracing & Profiling:** Tempo, Pyroscope

### Datenfluss:
> RFC3164 Devices -> **syslog-ng** (UDP/2514) -> **Alloy** (UDP/1514) -> **Loki** (Port 3100) <- **Grafana** (Port 3000)

---

## 🛠️ Schnellstart

### Voraussetzungen
*   Docker & Docker Compose
*   Mindestens 4GB RAM empfohlen

### Installation
1.  Repository klonen:
    ```bash
    git clone https://github.com/auge02-git/Grafana-loki-syslog-aio.git
    cd Grafana-loki-syslog-aio
    ```
2.  Stack starten (Full Example):
    ```bash
    docker-compose -f ./docker-compose.yml up -d
    ```

3.  **Grafana öffnen:**
    Navigiere zu `http://localhost:3000`. Das Dashboard "Loki Syslog AIO - Overview" ist vorkonfiguriert und ohne Login (Anonymous Admin) erreichbar.

---

## 📂 Deployment Optionen

Je nach Anwendungsfall stehen verschiedene Compose-Dateien zur Verfügung:

| Datei | Beschreibung |
| :--- | :--- |
| `docker-compose.yml` | **Standard:** Full Stack inkl. Alloy, Tempo, Pyroscope & Monitoring. |
| `docker-compose-with-generator.yml` | Inklusive Syslog-Generator für Testdaten. |
| `docker-compose-filesystem.yml` | Nutzt das lokale Dateisystem statt MinIO für Loki. |
| `docker-compose-without-monitoring.yml` | Nur die Kernkomponenten (Loki, Grafana, Alloy, syslog-ng). |

---

## ⚙️ Konfiguration

### Loki Storage
Standardmäßig nutzt der Haupt-Stack **MinIO** als S3-kompatiblen Speicher. Möchtest du stattdessen das Dateisystem nutzen, verwende die `docker-compose-filesystem.yml` oder ändere das Volume Mapping in der `docker-compose.yml`:

```yaml
volumes:
  - ./config/loki-config-filesystem.yml:/etc/loki/loki-config.yml:ro
```