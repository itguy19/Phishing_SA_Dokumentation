#import "@preview/gantty:0.5.1": gantt
#import "@preview/ost-ifs-thesis:1.0.0": styled-table

#set page(flipped: true)

= Projektmanagement

== Langfristiger Zeitplan

Für die Studienarbeit gilt die *\~240 Stunden* Arbeitszeit einzuplanen. 
#figure(
    scale(80%, reflow: true, gantt(yaml("/resources/gantt.yaml"))),
    kind: image,
    caption: [Langfristiger Zeitplan],
)

#pagebreak()
#set page(flipped: false)

== Vorgehen im Projekt
(Prozess, Workflows, Meilensteine)

== Qualitätssicherung
(Test-Philosophie, Definition of Done, CI/CD-Pipelines, Reviews)

#pagebreak()
== Risikomanagement

=== Pre-Mitigation Risiken
#figure(
  image("/figures/risk_matrix_before_mitigation.svg"),
  caption: [
    Risikomatrix vor Risikomitigation
  ],
)

#figure(
  caption: [Risikotabelle],
  styled-table(
    columns: (auto, 1fr, auto),
    header: ("Risiko-ID", "Risiko-Beschreibung", "Kategorie"),

    [R-1], [Die Dokumentation entspricht den OST-Guidelines nicht.], [#align(center)[#circle(radius: 5pt, fill: rgb("#199827"))]],
    [R-2], [Die Studienarbeit kann innerhalb des Zeitlimits nicht erfolgreich abgeschlossen werden.], [#align(center)[#circle(radius: 5pt, fill: rgb("f8f81e"))]],
    [R-3], [Die Dokumentation wird während des Projekts nicht adäquat gepflegt.], [#align(center)[#circle(radius: 5pt, fill: rgb("#f8f81e"))]],
    [R-4], [Scope Creeping (Umfangsausweitung) der Studienarbeit.], [#align(center)[#circle(radius: 5pt, fill: rgb("#f8f81e"))]],
    [R-5], [Es ist nicht möglich, eine Phishing-Landing-Page zu bauen, die Sicherheitsscanner täuschen kann.], [#align(center)[#circle(radius: 5pt, fill: rgb("#fc1c19"))]],
    [R-6], [Die Studienarbeit bietet keinen Mehrwert für avantguard.], [#align(center)[#circle(radius: 5pt, fill: rgb("#fc1c19"))]],
    [R-7], [Beim Research werden keine erfolgreiche Anti-Analysis-Techniken gegen Sicherheitsscanner gefunden.], [#align(center)[#circle(radius: 5pt, fill: rgb("#fc1c19"))]],
  ),
)

=== Post-Mitigation Risiken

#figure(
  caption: [Mitigationstabelle],
  styled-table(
    columns: (auto, auto, auto),
    header: ("Risiko-ID", "Mitigations-Beschreibung", "Neue Kategorie"),

    [R-1], [Am Anfang des Projekts soll eine Liste mit Anforderungen an die Dokumentation erstellt werden, die vor der Abgabe der Arbeit überprüft werden müssen. Die Liste soll durchgangen werden und wie eine Checkliste abgehakt werden.], [#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
    [R-2], [Während der Arbeit soll nicht nur qualitativ, aber auch quantitativ 17 Stunden Arbeit in der Woche angestrebt werden. Dies sollte sicherstellen, dass aus dem Zeitbudget das bestmögliche Resultat rausgeholt wird.],[#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
    [R-3], [Von Anfang an sollte jede Woche mindestens drei Stunden lang dokumentiert werden. Diese Massnahme stellt sicher, dass die Dokumentation während des Projekts aktuell gehalten wird.], [#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
    [R-4], [Am Anfang sollten mit Hilfe von Meetings detaillierte nicht-funktionale sowie funktionale Anforderungen erstellt werden. Diese müssen den Vorstellungen von avantguard entsprechen und ein machbares und realistisches Projekt sicherstellen.], [#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
    [R-5], [Durch viel in Phishing-Research investierte Zeit sollte das Risiko minimiert werden, indem Strategien und Techniken gelernt werden.], [#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
    [R-6], [Gegen Ende der Arbeit wird eine Präsentation im Büro von avantguard gehalten, um sicherzustellen, dass avantguard einen Überblick über die Arbeit verschaffen kann, ein Wissenstransfer stattfindet und avantguard eine Gelegenheit hat, Fragen bezüglich des Projekts zu stellen. Diese Präsentation soll den Mehrwert des Projekts für avantguard maximalisieren.], [#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
    [R-7], [Ein Kurs von MaldevAcademy wird gekauft, um die benötigte Anti-Analysis-Techniken anzueignen.], [#align(center)[#circle(radius: 7pt, fill: rgb("#199827"))]],
  ),
)

#figure(
  image("/figures/risk_matrix_after_mitigation.svg"),
  caption: [
    Risikomatrix nach Risikomitigation
  ],
)

== Zeiterfassung

#pagebreak()

== Meetings

=== Überblick

#table(
  columns: 5,
  [Nr.], [Datum], [Zeit], [Name], [Teilnehmende],

  [1.], [29.09.2026], [11:00-11:30], [Kick-off Meeting], [Dr. Arno Wagner, András Tarlós],
  [2.], [29.09.2026], [18:00-19:00], [Requirements-Eng.], [Sandro Ackerman, András Tarlós],
  [3.], [], [], [], [],
)

#pagebreak()
=== Protokoll

==== Kick-off Meeting

#let protocol-field(label, content) = {
  grid(
    columns: (2.8cm, 1fr),
    column-gutter: 1em,
    inset: (top: 0.30em, bottom: 0.30em),
    align: (left, left),
    [#text(weight: "bold")[#label]],
    [#content],
  )
}

#block(
  width: 100%,
  stroke: 0.7pt + luma(180),
  radius: 4pt,
  inset: 0.8em,
)[
  #protocol-field(
    "Teilnehmende",
    [Dr. Arno Wagner, András Tarlós],
  )

  #protocol-field(
    "Datum",
    [29.09.2026],
  )

  #protocol-field(
    "Uhrzeit",
    [18:00 - 19:00],
  )

  #protocol-field(
    "Ablauf",
    [
      1. Wagner stellt seine Erwartungen an die Studienarbeit (SA) vor:    
        - Das Problem wird definiert.
        - Der Stand der Technik wird beschrieben.
        - Die Motivation der Arbeit wird definiert.
        - Die Ziele der Arbeit sind definiert. 
        - Es wird beschrieben, wie getestet wird.
        - Beim Abschluss wird beschrieben, was die Arbeit gebracht hat. 
2. Tarlós stellt seine Fragen an Wagner.
3. Die erste Version der Dokumentation wird mit Wagner überprüft und unnötige Inhalte werden gelöscht.
    ],
  )

  #protocol-field(
    "Erkenntnisse",
    [
- Während der SA können potenzielle Themen für die Bachelorarbeit identifiziert werden.
- Eine Präsentation bei der SA ist nicht obligatorisch.
- Falls beim Praxispartner präsentiert wird, sollte auch Wagner  einladen werden, falls möglich.
- Meetings sind flexibel am Montag.
- Meetings sind alle zwei Wochen vorgesehen.
- Das Zertifikat vom MaldevAcademy-Kurs sowie das Inhaltsverzeichnis des Kurses dem Anhang hinzufügen.
    ],
  )
]

#pagebreak()
==== Requirements-Engineering

#let protocol-field(label, content) = {
  grid(
    columns: (2.8cm, 1fr),
    column-gutter: 1em,
    inset: (top: 0.30em, bottom: 0.30em),
    align: (left, left),
    [#text(weight: "bold")[#label]],
    [#content],
  )
}

#block(
  width: 100%,
  stroke: 0.7pt + luma(180),
  radius: 4pt,
  inset: 0.8em,
)[
  #protocol-field(
    "Teilnehmende",
    [Sandro Ackerman, András Tarlós],
  )

  #protocol-field(
    "Datum",
    [29.09.2026],
  )

  #protocol-field(
    "Uhrzeit",
    [11:00 - 11:30],
  )

  #protocol-field(
    "Ablauf",
    [
     1. Ackerman stellt vor, wie eine typische Phishing-Simulation bei der avantguard cyber security AG aussieht.
     2. Tarlós stellt Fragen zur Phishing-Infrastruktur.
     3. Ackerman spezifiziert das Problem bei der Phishing-Simulation.
     4. Es wurde eine für diese Studienarbeit relevante Experimentidee entwickelt.
    ],
  )

  #protocol-field(
    "Erkenntnisse",
    [
        - Für die Phishing-Infrastruktur werden die kleinsten Ubuntu-VMs auf Azure gemietet. Auf einer VM wird der GoPhish-Server gehostet, während eine andere aktuell als Reverse-Proxy verwendet wird.
        - Das Admin-Portal des GoPhish-Servers ist nur intern von dem IP-Bereich von avantguard erreichbar; alle anderen IPs werden geblockt.
        - Avantguard hat lange Let's-Encrypt-Zertifikate verwendet, neuerdings aber von Azure ausgestellte Zertifikate (https://learn.microsoft.com/en-us/azure/virtual-machines/create-fqdn). Das hat den Vorteil, dass Microsoft Ltd. der Aussteller des Zertifikats ist.
        - Bei Phishing-Simulationen werden fast ausschliesslich Microsoft-Login-Kopien verwendet. 
        - Bei verschiedenen Kunden ist eine Änderung des Microsoft-Logos und des Hintergrunds vorgesehen, die bei der Phishing-Simulation repliziert werden muss. Firmen können das Logo und das Hintergrundbild von ihrem Microsoft-Login individualisieren.
        - Die aktuell verwendete Microsoft-Login-Kopie von avantguard basiert auf einem Template und wurde von Hand geschrieben.
        - Avantguard hat das Problem, dass ihres Phishing-Landing-Page nach dem Start der Phishing-Simulation meistens innerhalb von zwei Tagen als Phishing markiert wird. Falls die E-Mails nicht ausgeschickt werden, wird das Landing-Page nicht als Phishing markiert. Daraus haben Ackerman und Tarlós abgeleitet, dass höchstwahrscheinlich die E-Mail-Provider die Links zum Scannen weiterleiten. 
        - Um das in der letzten Bulletpoint erwähnte Problem zu bestätigen, wurde ein Experiment konzipiert, bei dem der Website-Verkehr einer Phishing-Webseite vor und nach dem Versenden von E-Mails beobachtet werden sollte.
        - Ein potenzielles IOC von GoPhish könnte der statische URL-Parameter "id" sein.
        - Die Ergebnisse der Studienarbeit sollten in Form von einer Präsentation bei avantguard vorgestellt werden. Wagner darf ebenfalls eingeladen werden. Die Präsentation sollte der Firma einen Mehrwert bieten und die Kernaussagen der Arbeit ohne schulische Formalitäten vermitteln.
    ],
  )
]


