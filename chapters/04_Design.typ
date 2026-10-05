#import "@preview/ost-ifs-thesis:1.0.0": styled-table


= Design

== Infrastruktur

#lorem(50)

== Phishing-Landing-Page

Kunde muss definiert werden.

=== Kategorien von Operational Security Massnahmen

Das Bestreben, eine schwer-erkennbare Landing-Page zu erstellen, ist keine leichte Aufgabe. Das Internet ist voller Bots, Crawler und Security-Scanner, die neu freigeschaltete Domains so schnell wie möglich durchforsten. Damit die in dieser Arbeit gebauter Landing-Page möglichst lange aushält und nicht verbrannt wird - d.h. nicht von Sicherheitsdiensten erkannt wird -, muss die Operational Security (OPSEC) der Phishing-Simulation gescheit aufgebaut werden.

Um eine hohe OPSEC zu erreichen, müssen verschiedene Sicherheitsmassnahmen und Strategien evaluiert und ausgewertet werden, um den Erfolg einer Phishing-Simulation zu maximieren. Im Grunde genommen können OPSEC-Sicherheitsmassnahmen für Phishing in zwei Kategorien eingeordnet werden:

1. Bot-Abwehr
2. Analyseerschwerung

Zur *Bot-Abwehr* gehören Massnahmen, die das Leben von Bots erschweren sollten, indem sie erkannt werden und die tatsächliche Landing-Page nicht angezeigt wird. Bots, Crawler oder Sicherheits-Scanner sollten nicht zu unserer tatsächlichen Landing-Page gelangen, da damit die Wahrscheinlichkeit erhöhen würde, dass sie eine Webseite als verdächtig oder Phishing markieren.

Zur *Analyseerschwerung* gehören Massnahmen, die die Analyse einer Landing-Page erschweren sollte, sei es ein Security-Researcher oder ein automatisierter Scanner, der die Landing-Page analysiert. Hierbei sollten traditionelle signatur-basierte Security-Scanner umgangen werden um die operation der Phishing-Simulation zu gewährleisten.


In den nächsten zwei Kapiteln werden die zwei Kategorien mit einer ausführlichen Liste von möglichen Massnahmen ausgestattet. Das sollte dem Leser einen Überblick darüber verschaffen, welche Arten von Massnahmen zur jeweiligen Kategorie gehören. Die Listen sind nicht abschliessend, trotzdem werden die Massnahmen für die finale Phishing-Landing-Page von dieser Liste gewählt und begründet, weshalb diese gewählt wurde. 

== Bot-Abwehr

Komplexität: Niedrig, Mittel, Hoch 

#figure(
  caption: [Liste von Bot-Abwehr Massnahmen.],
  styled-table(
    columns: (auto, 1fr, auto),
    header: ("Name", "Beschreibung", "Komplexität"),

    [Geoblocking], [Basierend auf der IP-Adresse kann der Standort des Clients identifiziert werden. Falls während einer Phishing-Simulation in der Schweiz ein Client aus dem Demokratischen Republik Kongo versucht die Landing-Page zu besichtigen, kann er geblockt werden; höchstwahrscheinlich ist er ein Bot.], [Niedrig],
    [TLD-Wahl], [Es ist empfohlen, eine weltweit anerkannte TLD wie `.com`, `.org`, oder `.net` zu wählen, damit eine Landing-Page nicht ungewollt geblockt wird.], [Niedrig],
    [Domain-Wahl], [Die Firma des Kunden sollte nicht im Second-Level-Domain registriert werden. Es ist empfohlen, die Firma im Subdomain zu verwenden, da viele Drittanbieter mit Firma des Kunden im Subdomain für den Kunden hosten. Beispiel: Der Drittanbieter Safehosting AG hostet für BigMug AG unter dem domain `bigmug.safehosting.com`.], [Niedrig],
    [Domain Add-ons], [Die Dauer des registrierten Domains sollte nicht länger als ein Jahr sein, da die Domains meistens viel schneller verbrannt werden. Das Privacy-Add-on muss unbedingt mit dem Domain gekauft werden; der Kauf verhindert, dass die Domain-Registrar für die Öffentlichkeit zugänglich wird.], [Niedrig],
    [Reputation des Domains], [Es soll sichergestellt werden, dass der ausgewählte, aber noch nicht gekaufte Domain, eine gute Reputation hat. Dazu können Tools wie Whois-History, VirustTotal, URLScan.io und die WaybackMachine verwendet werden.], [Niedrig],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
    [TLD Wahl], lorem(6), [Should],
  ),
)

== Analyseerschwerung

#figure(
  caption: [Liste von Analyseerschwerung Massnahmen.],
  styled-table(
    columns: (auto, 1fr, auto),
    header: ("Name", "Beschreibung", "Komplexität"),
    [Meta Tags für SEO], lorem(5), [Should],
  ),
)