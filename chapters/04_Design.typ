#import "@preview/ost-ifs-thesis:1.0.0": styled-table


= Design

== Infrastruktur

#lorem(50)

== Phishing-Landing-Page

Kunde muss definiert werden.

=== Kategorien von Operational Security Massnahmen

Das Bestreben, eine schwer-erkennbare Landing-Page zu erstellen, ist keine leichte Aufgabe. Das Internet ist voller Bots, Crawler und Security-Scanner, die neu freigeschaltete Domains so schnell wie möglich durchforsten. Damit die in dieser Arbeit gebaute Landing-Page möglichst lange aushält und nicht verbrannt wird - d.h. nicht von Sicherheitsdiensten erkannt wird -, muss die Operational Security (OPSEC) der Phishing-Simulation gescheit aufgebaut werden.

Um eine hohe OPSEC zu erreichen, müssen verschiedene Sicherheitsmassnahmen und Strategien evaluiert und ausgewertet werden, um den Erfolg einer Phishing-Simulation zu maximieren. Im Grunde genommen können OPSEC-Sicherheitsmassnahmen für Phishing in zwei Kategorien eingeordnet werden:

1. Bot-Abwehr
2. Analyseerschwerung // TODO: Anti-Analysis

Zur *Bot-Abwehr* gehören Massnahmen, die das Leben von Bots erschweren sollten, indem sie erkannt werden und die tatsächliche Landing-Page nicht angezeigt wird. Bots, Crawler oder Sicherheitsscanner sollten nicht zur  tatsächlichen Landing-Page gelangen, die Phishing-Opfer sehen, da damit die Wahrscheinlichkeit erhöhen würde, dass sie eine Webseite als verdächtig oder Phishing markieren.

Zur *Analyseerschwerung* gehören Massnahmen, die die Analyse einer Landing-Page erschweren sollte, sei es ein Security-Researcher oder ein automatisierter Scanner, der die Landing-Page analysiert. Hierbei sollten traditionelle signatur-basierte Security-Scanner umgangen werden um die operation der Phishing-Simulation zu gewährleisten.


In den nächsten zwei Kapiteln werden die zwei Kategorien mit einer ausführlichen Liste von möglichen Massnahmen ausgestattet. Das sollte dem Leser einen Überblick darüber verschaffen, welche Arten von Massnahmen zur jeweiligen Kategorie gehören. Die Listen sind nicht abschliessend, trotzdem werden die Massnahmen für die finale Phishing-Landing-Page von dieser Liste gewählt und begründet, weshalb diese gewählt wurde. 


Die Listen basieren auf dem Kurs von mr.d0x et al. @maldev-academy-course-2026 und enthält für diese Arbeit relevante Strategien, von denen für beim Endprodukt eine Kombination der Strategien angewandt wird. 

== Bot-Abwehr Strategien

Komplexität: Niedrig, Mittel, Hoch 

#figure(
  caption: [Liste von Bot-Abwehr Massnahmen.],
  styled-table(
    columns: (4.3cm, 1fr),
    header: ("Name", "Beschreibung"),

    [Geoblocking], [Basierend auf der IP-Adresse kann der Standort des Clients identifiziert werden. Falls während einer Phishing-Simulation in der Schweiz ein Client aus dem Demokratischen Republik Kongo versucht die Landing-Page zu besichtigen, kann er geblockt werden; höchstwahrscheinlich ist er ein Bot.],
    [TLD-Wahl], [Es ist empfohlen, eine weltweit anerkannte TLD wie `.com`, `.org`, oder `.net` zu wählen, damit eine Landing-Page nicht ungewollt geblockt wird.],
    [Domain-Wahl], [Die Firma des Phishing-Simulation-Kunden sollte nicht im Second-Level-Domain registriert werden. Es ist empfohlen, die Firma im Subdomain zu verwenden, da viele Drittanbieter die Firma des Kunden im Subdomain für den Kunden hosten. Beispiel: Der Drittanbieter Safehosting AG hostet für BigMug AG unter dem Domain `bigmug.safehosting.com`.],
    [Domain Add-ons], [Die Dauer des registrierten Domains sollte nicht länger als ein Jahr sein, da die Domains meistens viel schneller verbrannt werden. Das Privacy-Add-on muss unbedingt mit dem Domain gekauft werden; der Kauf verhindert, dass die Domain-Registrar für die Öffentlichkeit zugänglich wird.],
    [Reputation des Domains], [Es soll sichergestellt werden, dass der ausgewählte, aber noch nicht gekaufte Domain, eine gute Reputation hat. Dazu können Tools wie Whois-History, VirustTotal, URLScan.io und die WaybackMachine verwendet werden.],
    [Wildcard-Zertifikat], [Wildcard-Zertifikate erhöhen die OPSEC, da sie für automatisierte Scanner das Scannen von Subdomains erschweren. In den _Certificate-Transparancy_-Logs (CT-Logs) wird ein Wildcard-Zertifikat als `*.domain.com` abgespeichert. Das bedeutet: Automatisierte Scanner können über Subdomains von CT-Logs nicht erfahren. Für die Entdeckung eines Subdomains müsste ein Scanner aktiv Subdomains suchen und hoffen, dass es einen Treffer gibt @maldev-academy-course-2026[Modul 13].],
    [Server-Sicherheit], [Damit Bots eine Phishing-Webseite nicht als bösartig einstufen, müssen wir sicherstellen, dass HTTP-Zugriffe und direkte IP-Zugriffe verboten sind; Server-Informationen über HTTP-Header nicht freigegeben werden; und dass der _SSH-Verbose-Banner_ ausgestellt ist @maldev-academy-course-2026[Modul 23].],
    [Reverse-Proxy in der #linebreak() Allowlist], [Damit der Phishing-Server von extern nicht gescannt wird, darf nur die IP-Adresse des Reverse-Proxys über HTTPS mit dem Server kommunizieren. Ein direkter Zugriff auf die Inhalte des Phishing-Servers soll nicht möglich sein @maldev-academy-course-2026[Modul 30].],
    [Referrer-Policy], [Falls die Phishing-Landing-Page nach erfolgreicher credential capturing den Client zur legitimen Login-Webseite weiterleitet, muss sichergestellt werden, dass beim Referrer-Policy "no-referrer" steht. Umsonsten könnte es der Target-Firma auffallen, dass suspiciously viel traffic vom dem Phishing-Domain stammt @maldev-academy-course-2026[Modul 34].],
    [Headless-Browsers], [Viele automatisierte Bots verwenden einen _Headless-Browser_, um Webseiten zu scannen. Anhand des `navigator.webdriver`-JavaScript-Objekts kann im Code herausgefunden werden, ob der Client einen _Headless-Browser_ verwendet oder nicht. Im positiven Fall, kann der Client geblockt oder zur legitimen Webseite weitergeleitet werden @maldev-academy-course-2026[Modul 38].],
    [Bot User-Agents], [Anhand von bekanntent User-Agents wie `curl` können trivialere Bots detektiert und geblockt werden @maldev-academy-course-2026[Modul 39].],
    [Manipulierte #linebreak() User-Agents], [Bei Bots ist es trivial, den User-Agent zu manipulieren, damit er als ein legitimer Client aussieht. Auf der Phishing-Webseite kann das `navigator.userAgent`-Objekt verwendet werden, um mit dem `User-Agent` vom Header zu vergleichen; falls die beiden nicht den gleichen Wert haben, wurde der Header manipuliert @maldev-academy-course-2026[Modul 40].],
    
    [], [],
    [], [],
    [], [],
    [], [],
    [], [],
    [], [],
  ),
)

== Analyseerschwerung

#figure(
  caption: [Liste von Analyseerschwerung Massnahmen.],
  styled-table(
    columns: (auto, 1fr),
    header: ("Name", "Beschreibung"),
    [Meta Tags für SEO], lorem(5),
    [Dynamische HTML-Generierung], [Der Inhalt der Phishing-Webseite kann mit JavaScript dynamisch generiert werden, damit statische Scanner die Webseite nicht als bösartig markieren @maldev-academy-course-2026[Modul 42].],
    [Code-_Obfuscation_], [Um die Analyse der Phishing-Webseite zu erschweren, kann der Inhalt mit Base64, XOR, AES-Verschlüsselung und weitere obfusziert werden. Diese Massnahme reduzieren die Phishing-Detektionsraten @maldev-academy-course-2026[Modul 43,44,45].],
    [Zero-Width Obfuscation], [],
    [Externe Dateien], [Für die Übersicht und gegen Detektionsversuchen ist es von Vorteil, wenn JavaScript nicht direkt in `index.html` zu finden ist, sondern in einem externen File @maldev-academy-course-2026[Modul 48].],
    [File Extension Spoofing], [],
    [Content Camouflage], [],
    [Populäre JavaScript-Libraries #linebreak() Modifizieren], [],
    [Webseite Keyring], [],
    [GoPhish Default-Keyring], [],
    [Incognito mode], [],
    [JA4 Fingerprinting], [],
    [Reverse DNS-Query], [],
    [], [],
  ),
)