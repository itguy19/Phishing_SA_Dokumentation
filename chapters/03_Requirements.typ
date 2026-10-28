#import "@preview/ost-ifs-thesis:1.0.0": styled-table

= Anforderungen

MoSCow

- Es sollten 10 verschiedene statische Webseiten bei virusTotal getestet werden.
- Die finale Landing-Page muss einem Microsoft Page gleicht aussehen. 10 Personen fragen, ob ihnen etwas Verdächtiges bei der Microsoft Phishing-Landing-Page auffällt. 
- Die Landing-Page muss über GoPhish laufen
- Die finale Landing-Page darf von VirustTotal nicht erkannt werden.
- Eine Phishing-Simulation sollte 7 Tage lang beibehalten werden.
- Experiment: Phishing-Webseite erstellen und verschiedenen automatisierte Scanner geben, die im Internet sind + drei verschiedenen E-Mai Clients den Link zur Phishing-Page schicken (sie scannen die URLs wahrscheinlich auch)
- Eine ausführliche Tabelle mit OPSEC Techniken sollte erstellt werden, um avantguard eine Übersicht zu geben, welche Techniken es existieren. 

== Funktionale Anforderungen

#figure(
  caption: [VirusTotal-Baseline-Test mit statischen Webseiten.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-1],
    [Thema], [VirusTotal-Erkennungsbaseline],
    [Anforderung], [Es müssen 10 strukturell unterschiedliche, statische Webseiten (unterschiedlicher Aufbau, Technologie-Stack und Inhalt) erstellt und bei VirusTotal eingereicht werden, um eine Baseline für das Erkennungsverhalten der verschiedenen Scan-Engines zu ermitteln.],
    [Geltungsbereich], [Vorstudie / Testumgebung],
    [Massnahmen], [Erstellung von 10 strukturell unterschiedlichen Testseiten; Einreichung über VirusTotal-API oder Web-UI; Dokumentation der Scan-Ergebnisse pro Engine.],
    [Priorität], [Mittel],
    [Verifikation], [Auswertung der VirusTotal-Scan-Reports; Vergleich der Erkennungsraten zwischen den 10 Seiten.],
  ),
)

#figure(
  caption: [Visuelle Authentizität der Landing-Page.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-2],
    [Thema], [Visuelle Täuschungsqualität der Landing-Page],
    [Anforderung], [Die finale Landing-Page muss optisch und strukturell einer echten Microsoft-Anmeldeseite entsprechen (Layout, Farben, Logos, Schriftarten). Die Überzeugungskraft wird mittels eines kontrollierten Tests mit 10 Testpersonen überprüft, die angeben, ob ihnen etwas Verdächtiges auffällt.],
    [Geltungsbereich], [Phishing-Landing-Page],
    [Massnahmen], [Nachbau des Microsoft-Login-Interfaces; Durchführung eines strukturierten Awareness-Tests mit 10 Personen; Erhebung der Rückmeldungen per Fragebogen.],
    [Priorität], [Hoch],
    [Verifikation], [Auswertung der Testprotokolle; Anteil der Testpersonen, die keine Auffälligkeiten melden.],
  ),
)

#figure(
  caption: [Betrieb über GoPhish.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-3],
    [Thema], [Technische Infrastruktur],
    [Anforderung], [Die Landing-Page muss über das GoPhish-Framework gehostet und ausgeliefert werden, inklusive Kampagnen- und Tracking-Funktionalität.],
    [Geltungsbereich], [Phishing-Simulationsplattform],
    [Massnahmen], [Installation und Konfiguration einer GoPhish-Instanz; Einbindung der Landing-Page als GoPhish-Template; Konfiguration von SMTP und Tracking-Parametern.],
    [Priorität], [Hoch],
    [Verifikation], [Funktionstest der GoPhish-Instanz; Nachweis korrekter Protokollierung der Zugriffe über GoPhish.],
  ),
)

#figure(
  caption: [Nicht-Erkennung durch VirusTotal.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-4],
    [Thema], [Umgehung von Erkennungsmechanismen],
    [Anforderung], [Die finale, über GoPhish ausgelieferte Landing-Page darf von keiner der VirusTotal-Scan-Engines als bösartig bzw. als Phishing eingestuft werden.],
    [Geltungsbereich], [Phishing-Landing-Page (produktiv)],
    [Massnahmen], [Iterative Tests gegen VirusTotal; Anpassung der Seite basierend auf den Scan-Ergebnissen; Referenz auf die OPSEC-Techniken-Übersicht (REQ-7).],
    [Priorität], [Hoch],
    [Verifikation], [VirusTotal-Report zeigt zum Zeitpunkt des Livegangs 0 Erkennungen.],
  ),
)

#figure(
  caption: [Laufzeit der Simulation.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-5],
    [Thema], [Kampagnendauer],
    [Anforderung], [Die Phishing-Simulation muss über einen Zeitraum von 7 Tagen durchgehend aktiv und erreichbar bleiben, um aussagekräftige Interaktionsdaten zu sammeln.],
    [Geltungsbereich], [Gesamte Simulationskampagne],
    [Massnahmen], [Konfiguration der Kampagnenlaufzeit in GoPhish; laufendes Monitoring der Erreichbarkeit über den gesamten Zeitraum.],
    [Priorität], [Mittel],
    [Verifikation], [Server- und Uptime-Logs belegen durchgehende Erreichbarkeit über 7 Tage.],
  ),
)

#figure(
  caption: [Experiment mit automatisierten Scannern und E-Mail-Clients.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-6],
    [Thema], [Verhalten automatisierter Sicherheitsscanner],
    [Anforderung], [Der Link zur Phishing-Seite wird an öffentlich verfügbare automatisierte URL-Scanner sowie an drei unterschiedliche E-Mail-Clients übermittelt, um deren Scan- bzw. Erkennungsverhalten zu beobachten und zu protokollieren.],
    [Geltungsbereich], [Experimentelle Validierung],
    [Massnahmen], [Auswahl mehrerer öffentlicher Scan-Dienste; Versand des Links über drei verschiedene E-Mail-Clients; serverseitige Protokollierung aller Zugriffe inkl. Zeitstempel und User-Agent (z.B. via GoPhish-Tracking).],
    [Priorität], [Mittel],
    [Verifikation], [Log-Auswertung: Unterscheidung automatisierter Scan-Zugriffe von menschlichen Zugriffen, zeitliche Zuordnung zu Versand.],
  ),
)

#figure(
  caption: [OPSEC-Techniken-Übersicht.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,

    [ID], [REQ-7],
    [Thema], [Dokumentation von OPSEC-Techniken],
    [Anforderung], [Es ist eine ausführliche, tabellarische Übersicht bestehender OPSEC-Techniken zu erstellen, die avantguard einen strukturierten Überblick über existierende Techniken, deren Zweck und Einsatzbereich gibt.],
    [Geltungsbereich], [Dokumentation / Wissenstransfer],
    [Massnahmen], [Literatur- und Praxisrecherche zu OPSEC-Techniken; Kategorisierung (z.B. nach Phase, Zweck, Komplexität); tabellarische Aufbereitung mit Quellenangaben.],
    [Priorität], [Mittel],
    [Verifikation], [Review der Tabelle durch avantguard; Prüfung auf Vollständigkeit und Plausibilität.],
  ),
)

== Nichtfunktionale Anforderungen

#figure(
  caption: [Non-functional requirements.],
  styled-table(
    columns: (auto, 1fr, auto),
    header: ("ID", "Requirement", "Priority"),

    [NFR-1], lorem(6), [Must],
    [NFR-2], lorem(7), [Must],
    [NFR-3], lorem(5), [Should],
    [NFR-4], lorem(6), [Should],
  ),
)
