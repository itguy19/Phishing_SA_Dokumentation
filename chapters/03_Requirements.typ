#import "@preview/ost-ifs-thesis:1.0.0": styled-table

= Anforderungen

Die Anforderungen dieser Arbeit werden mithilfe von der MoSCoW-Methode @wikipedia-moscow-priorisierung priorisiert.
Diese Methode unterteilt die Anforderungen in die folgenden Kategorien:
- *Must Have*: Unverzichtbar für die Arbeit.
- *Should Have*: Geniesst eine hohe Priorität, ist aber nicht lebensnotwendig.
- *Could Have*: Wünschenswert, wird aber nur umgesetzt, wenn Zeit und Ressourcen übrig bleiben. 
- *Won't Have*: Das Zeitbudget reicht nicht aus, um diese Anforderung umzusetzen.

== Funktionale Anforderungen

#figure(
  caption: [Übersicht der funktionalen Anforderungen.],
  styled-table(
    columns: (auto, 1fr, auto),
    header: ("ID", "Requirement", "Priority"),

    [FR-1], [VirusTotal-Erkennungsbaseline], [Must Have],
    [FR-2], [GoPhish in der Infrastruktur], [Must Have],
    [FR-3], [Verhalten der Phishing-Landing-Page nach Veröffentlichung], [Should],
    [FR-4], [Dokumentation von OPSEC-Techniken], [Must Have],
    [FR-5], [Reverse-Proxy vor dem GoPhish-Server], [Should Have],
    [FR-6], [Kombination von OPSEC-Techniken bei der Phishing-Landing-Page], [Must Have],
    [FR-7], [_Decoy_-Webseiten für Bots und Sicherheitsscanner], [Should],
    [FR-8], [Tiefenverteidigung], [Should],
  ),
)

#figure(
  caption: [VirusTotal-Baseline-Test mit Phishing-Webseiten.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [FR-1],
    [Thema], [VirusTotal-Erkennungsbaseline],
    [Anforderung], [Es müssen 10 unterschiedliche Microsoft-Login-Webseiten unterschiedlicher Aufbau und OPSEC-Techniken erstellt und bei VirusTotal eingereicht werden, um eine Baseline für das Erkennungsverhalten der verschiedenen Scan-Engines zu ermitteln.],
    [Geltungsbereich], [Phishing-Landing-Page],
    [Massnahmen], [Erstellung von 10 strukturell unterschiedlichen Testseiten; Einreichung über VirusTotal-API oder Web-UI; Dokumentation der Scan-Ergebnisse pro Engine.],
    [Priorität], [Must Have],
    [Verifikation], [Auswertung der VirusTotal-Scan-Reports und Vergleich der Erkennungsraten zwischen den 10 Seiten.],
  ),
)


#figure(
  caption: [Betrieb über GoPhish.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [FR-2],
    [Thema], [GoPhish in der Infrastruktur],
    [Anforderung], [Die Landing-Page muss über das GoPhish-Open-Source-Framework gehostet und ausgeliefert werden.],
    [Geltungsbereich], [Phishing-Simulationsplattform],
    [Massnahmen], [Installation und Konfiguration einer GoPhish-Instanz auf Azure; Einbindung der Landing-Page als GoPhish-Template.],
    [Priorität], [Must Have],
    [Verifikation], [Funktionstest der GoPhish-Instanz.],
  ),
)

#figure(
  caption: [Experiment mit automatisierten Scannern und E-Mail-Clients.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [FR-3],
    [Thema], [Verhalten der Phishing-Landing-Page nach Veröffentlichung],
    [Anforderung], [Während der 7-tägige Phishing-Simulation wird der Link zur Phishing-Seite an öffentlich verfügbare automatisierte URL-Scanner sowie an drei unterschiedliche E-Mail-Clients übermittelt, um deren Scan- bzw. Erkennungsverhalten zu beobachten und zu protokollieren.],
    [Geltungsbereich], [Experimentelle Validierung],
    [Massnahmen], [Auswahl mehrerer öffentlicher Scan-Dienste; Versand des Links über drei verschiedene E-Mail-Clients; serverseitige Protokollierung aller Zugriffe inkl. Zeitstempel und User-Agent.],
    [Priorität], [Should Have],
    [Verifikation], [Log-Auswertung: Unterscheidung automatisierter Scan-Zugriffe von menschlichen Zugriffen, zeitliche Zuordnung zu Versand.],
  ),
)

#figure(
  caption: [OPSEC-Techniken-Übersicht.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [FR-4],
    [Thema], [Dokumentation von OPSEC-Techniken],
    [Anforderung], [Es ist eine ausführliche, tabellarische Übersicht verbreiteten OPSEC-Techniken zu erstellen, die avantguard cyber security AG einen strukturierten Überblick über existierende Techniken, deren Zweck und Einsatzbereich gibt.],
    [Geltungsbereich], [Dokumentation],
    [Massnahmen], [Literatur- und Praxisrecherche zu OPSEC-Techniken (Maldev Academy); Kategorisierung und tabellarische Aufbereitung mit Quellenangaben.],
    [Priorität], [Must Have],
    [Verifikation], [Die Tabelle enthält alle in der Arbeit verwendete OPSEC-Techniken mit einer einfach zu verstehenden Beschreibung.],
  ),
)

#pagebreak()

== Nichtfunktionale Anforderungen

#figure(
  caption: [Übersicht der nicht-funktionalen Anforderungen.],
  styled-table(
    columns: (auto, 1fr, auto),
    header: ("ID", "Requirement", "Priority"),

    [NFR-1], [Visuelle Täuschungsqualität der Landing-Page], [Must Have], 
    [NFR-2], [Umgehung von Erkennungsmechanismen], [Must Have],
    [NFR-3], [Kampagnendauer], [Must Have],
    [NFR-4], [Nachvollziehbarkeit und Transparenz der Implementation und Konfiguration der Infrastruktur], [Must Have],
  ),
)

#figure(
  caption: [Visuelle Täuschungsqualität der Landing-Page.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [NFR-1],
    [Thema], [Visuelle Täuschungsqualität der Landing-Page],
    [Anforderung], [Die finale Landing-Page muss optisch und strukturell einer echten Microsoft-Anmeldeseite entsprechen (Layout, Farben, Logos, Schriftarten). Die Überzeugungskraft wird mittels eines kontrollierten Tests mit 10 Testpersonen überprüft, die angeben, ob ihnen etwas Verdächtiges auffällt.],
    [Geltungsbereich], [Phishing-Landing-Page],
    [Massnahmen], [Nachbau des Microsoft-Login-Portals.],
    [Priorität], [Must Have],
    [Verifikation], [Auswertung der Testprotokolle; Anteil der Testpersonen, die keine Auffälligkeiten melden.],
  ),
)


#figure(
  caption: [Nicht-Erkennung durch VirusTotal.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [NFR-2],
    [Thema], [Umgehung von Erkennungsmechanismen],
    [Anforderung], [Die finale, über GoPhish ausgelieferte Landing-Page darf von keiner der VirusTotal-Scan-Engines als bösartig bzw. als Phishing eingestuft werden.],
    [Geltungsbereich], [produktive Phishing-Landing-Page],
    [Massnahmen], [Iterative Tests gegen VirusTotal; Anpassung der Seite basierend auf den Scan-Ergebnissen; Referenz auf die OPSEC-Techniken-Übersicht (REQ-7).],
    [Priorität], [Must Have],
    [Verifikation], [VirusTotal-Report zeigt zum Zeitpunkt des Phishing-Landing-Page-Deployments 0 Erkennungen.],
  ),
)

#figure(
  caption: [Laufzeit der Simulation.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [NFR-3],
    [Thema], [Kampagnendauer],
    [Anforderung], [Die Phishing-Simulation muss über einen Zeitraum von 7 Tagen durchgehend aktiv und erreichbar bleiben.],
    [Geltungsbereich], [Gesamte Simulationskampagne],
    [Massnahmen], [Konfiguration der Kampagnenlaufzeit in GoPhish; laufendes Monitoring der Erreichbarkeit über den gesamten Zeitraum.],
    [Priorität], [Should Have],
    [Verifikation], [Server- und Uptime-Logs belegen durchgehende Erreichbarkeit über 7 Tage und die Webseite wird nicht als Phishing eingestuft.],
  ),
)