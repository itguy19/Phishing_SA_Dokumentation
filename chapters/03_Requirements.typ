#import "@preview/ost-ifs-thesis:1.0.0": styled-table

= Requirements

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
  caption: [Functional requirements.],
  table(
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    stroke: 0.5pt + black,
    
    [ID], [NFR-1],
    [Thema], [],
    [Anforderung], [],
    [Geltungsbereich], [Phising-Landing-Page],
    [Massnahmen], [],
    [Priorität], [Hoch],
    [Verifikation], [],
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
