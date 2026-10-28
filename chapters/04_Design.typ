#import "@preview/ost-ifs-thesis:1.0.0": styled-table


= Design

== Infrastruktur

#lorem(50)

== Phishing-Landing-Page

Kunde muss definiert werden.

=== Kategorien von Operational Security Massnahmen

Das Bestreben, eine schwer-erkennbare Landing-Page zu erstellen, ist keine leichte Aufgabe. Das Internet ist voller Bots, Crawler und Security-Scanner, die neu freigeschaltete Domains so schnell wie möglich durchforsten. Damit die in dieser Arbeit gebaute Landing-Page möglichst lange aushält und nicht verbrannt wird - d.h. nicht von Sicherheitsdiensten erkannt wird -, muss die Operational Security (OPSEC) der Phishing-Simulation gescheit aufgebaut werden.

Um eine hohe OPSEC zu erreichen, müssen verschiedene Sicherheitsmassnahmen und Strategien evaluiert und ausgewertet werden, um den Erfolg einer Phishing-Simulation zu maximieren. Im Grunde genommen können OPSEC-Sicherheitsmassnahmen für Phishing in zwei Kategorien eingeordnet werden:

#figure(
  image("/assets/1-bots-2-analysis.png", width: 75%),
  caption: [
    Die zwei OPSEC-Kategorien
  ],
)

Zur *Bot-Abwehr* gehören Massnahmen, die die Effektivität von Bots senken sollten, indem sie erkannt werden und die tatsächliche Landing-Page nicht angezeigt wird. Bots, Crawler oder Sicherheitsscanner sollten nicht zur tatsächlichen Landing-Page gelangen, die Zielpersonen sehen, da damit die Wahrscheinlichkeit erhöhen würde, dass sie eine Webseite als verdächtig oder als Phishing markieren.

Zur *Analyseerschwerung* gehören Massnahmen, die die Analyse einer Landing-Page erschweren sollte, sei es ein Security-Researcher oder ein automatisierter Scanner, der die Landing-Page analysiert. Hierbei sollten traditionelle signatur-basierte Security-Scanner umgangen werden um die operation der Phishing-Simulation zu gewährleisten.

In den nächsten zwei Kapiteln werden die zwei Kategorien mit einer ausführlichen Liste von möglichen Massnahmen ausgestattet. Das sollte dem Leser einen Überblick darüber verschaffen, welche Arten von Massnahmen zur jeweiligen Kategorie gehören. Die Listen sind nicht abschliessend, trotzdem werden die Massnahmen für die finale Phishing-Landing-Page von dieser Liste gewählt und begründet, weshalb diese gewählt wurde. 

Die Listen basieren auf dem Kurs von mr.d0x et al. @maldev-academy-course-2026 und enthält für diese Arbeit relevante Strategien, von denen für beim Endprodukt eine Kombination der Strategien angewandt wird. 

#pagebreak()

== Bot-Abwehr Strategien

Komplexität der Implementation: #text(rgb("#0a7900"))[Niedrig], #text(rgb("#d39e00"))[Mittel], #text(red)[Hoch].

#figure(
  caption: [Liste von Bot-Abwehr Massnahmen.],
  styled-table(
    columns: (4.3cm, 1fr),
    header: ("Name", "Beschreibung"),

    [#text(rgb("#0a7900"))[Geoblocking]], [Basierend auf der IP-Adresse kann der Standort des Clients identifiziert werden. Falls während einer Phishing-Simulation in der Schweiz ein Client aus dem Demokratischen Republik Kongo versucht die Landing-Page zu besichtigen, kann er geblockt werden; höchstwahrscheinlich ist er ein Bot.],
    [#text(rgb("#0a7900"))[TLD-Wahl]], [Es ist empfohlen, eine weltweit anerkannte TLD wie `.com`, `.org`, oder `.net` zu wählen, damit eine Landing-Page nicht ungewollt geblockt wird.],
    [#text(rgb("#0a7900"))[Domain-Wahl]], [Die Firma des Phishing-Simulation-Kunden sollte nicht im Second-Level-Domain registriert werden. Es ist empfohlen, die Firma im Subdomain zu verwenden, da viele Drittanbieter die Firma des Kunden im Subdomain für den Kunden hosten. Beispiel: Der Drittanbieter Safehosting AG hostet für BigMug AG unter dem Domain `bigmug.safehosting.com`.],
    [#text(rgb("#0a7900"))[Domain Add-ons]], [Die Dauer des registrierten Domains sollte nicht länger als ein Jahr sein, da die Domains meistens viel schneller verbrannt werden. Das Privacy-Add-on muss unbedingt mit dem Domain gekauft werden; der Kauf verhindert, dass die Domain-Registrar für die Öffentlichkeit zugänglich wird.],
    [#text(rgb("#0a7900"))[Reputation des Domains]], [Es soll sichergestellt werden, dass der ausgewählte, aber noch nicht gekaufte Domain, eine gute Reputation hat. Dazu können Tools wie Whois-History, VirustTotal, URLScan.io und die WaybackMachine verwendet werden.],
    [#text(rgb("#0a7900"))[Wildcard-Zertifikat]], [Wildcard-Zertifikate erhöhen die OPSEC, da sie für automatisierte Scanner das Scannen von Subdomains erschweren. In den _Certificate-Transparancy_-Logs (CT-Logs) wird ein Wildcard-Zertifikat als `*.domain.com` abgespeichert. Das bedeutet: Automatisierte Scanner können über Subdomains von CT-Logs nicht erfahren. Für die Entdeckung eines Subdomains müsste ein Scanner aktiv Subdomains suchen und hoffen, dass es einen Treffer gibt @maldev-academy-course-2026[Modul 13].],
    [#text(rgb("#0a7900"))[Serversicherheit]], [Damit Bots eine Phishing-Webseite nicht als bösartig einstufen, müssen wir sicherstellen, dass HTTP-Zugriffe und direkte IP-Zugriffe verboten sind; Server-Informationen über HTTP-Header nicht freigegeben werden; und dass der _SSH-Verbose-Banner_ ausgestellt ist @maldev-academy-course-2026[Modul 23].],
    [#text(rgb("#0a7900"))[Bot User-Agents]], [Anhand von bekanntent User-Agents wie `curl` können trivialere Bots detektiert und geblockt werden @maldev-academy-course-2026[Modul 39].],
    [#text(rgb("#0a7900"))[Referrer-Policy]], [Falls die Phishing-Landing-Page nach erfolgreicher credential capturing den Client zur legitimen Login-Webseite weiterleitet, muss sichergestellt werden, dass beim Referrer-Policy "no-referrer" steht. Umsonsten könnte es der Target-Firma auffallen, dass suspiciously viel traffic vom dem Phishing-Domain stammt @maldev-academy-course-2026[Modul 34].],
    [#text(rgb("#d39e00"))[Reverse-Proxy in der #linebreak() Allowlist]], [Damit der Phishing-Server von extern nicht gescannt wird, darf nur die IP-Adresse des Reverse-Proxys über HTTPS mit dem Server kommunizieren. Ein direkter Zugriff auf die Inhalte des Phishing-Servers soll nicht möglich sein @maldev-academy-course-2026[Modul 30].],
    [#text(rgb("#d39e00"))[Headless-Browsers]], [Viele automatisierte Bots verwenden einen _Headless-Browser_, um Webseiten zu scannen. Anhand des `navigator.webdriver`-JavaScript-Objekts kann im Code herausgefunden werden, ob der Client einen _Headless-Browser_ verwendet oder nicht. Im positiven Fall, kann der Client geblockt oder zur legitimen Webseite weitergeleitet werden @maldev-academy-course-2026[Modul 38].],
    [#text(rgb("#d39e00"))[Manipulierte #linebreak() User-Agents]], [Bei Bots ist es trivial, den User-Agent zu manipulieren, damit er als ein legitimer Client aussieht. Auf der Phishing-Webseite kann das `navigator.userAgent`-Objekt verwendet werden, um mit dem `User-Agent` vom Header zu vergleichen; falls die beiden nicht den gleichen Wert haben, wurde der Header manipuliert @maldev-academy-course-2026[Modul 40].],
  ),
)

#pagebreak()

== Analyseerschwerung

#figure(
  caption: [Liste von Analyseerschwerenden Massnahmen.],
  styled-table(
    columns: (auto, 1fr),
    header: ("Name", "Beschreibung"),
    [#text(rgb("#0a7900"))[File-Extension-Spoofing]], [Es besteht keine zwingende Notwendigkeit, JavaScript-Code direkt in einem `.js`-File zu speichern; andere Extensions wie `.css` oder `.woff` können auch JavaScript-Code beinhalten, erfolgreich in einem HTML-File geladen und ausgeführt werden @maldev-academy-course-2026[Modul 48].],
    [#text(rgb("#d39e00"))[Dynamische HTML-Generierung]], [Die Inhalte der Phishing-Webseite können mit JavaScript dynamisch generiert werden, damit statische Scanner Schwierigkeiten haben, die Webseite als bösartig zu markieren @maldev-academy-course-2026[Modul 42].],
    [#text(rgb("#d39e00"))[Code-_Obfuscation_]], [Um die Analyse der Phishing-Webseite zu erschweren, können verschiedene Verfahren zur Codierung oder Verschlüsselung der Inhalte, wie Base64, XOR, AES oder weitere Methoden verwendet werden. Diese Massnahme trägt zur Reduzierung der Phishing-Detektionsraten bei @maldev-academy-course-2026[Modul 43,44,45].],
    [#text(rgb("#d39e00"))[Zero-Width Obfuscation]], [Hierbei handelt es um eine unsichtbare Codierug, die dabei helfen kann, Sicherheitsscanner zu umgehen. @maldev-academy-course-2026[Modul 93]],
    [#text(rgb("#d39e00"))[Externe Dateien]], [Um die Übersicht zu wahren und Detektionsversuchen zu verhindern, ist es von Vorteil, wenn JavaScript nicht direkt in `index.html` gespeichert ist, sondern in einem externen File @maldev-academy-course-2026[Modul 48].],
    [#text(rgb("#d39e00"))[Inhaltscamouflage]], [Um den Inhalt einer JavaScript-Datei weniger auffällig zu machen, kann vor der Phishing-Logik legitimer Code stehen, damit die Datei auf dem ersten Blick als legitim erscheint. @maldev-academy-course-2026[Modul 48]],
    [#text(rgb("#d39e00"))[Populäre JavaScript-Bibliotheken #linebreak() Modifizieren]], [Falls Phishing-JavaScript-Code in populäre JavaScript-Bibliotheken eingebettet und versteckt wird, reduziert sich die Wahrscheinlichkeit einer Erkennung @maldev-academy-course-2026[Modul 48].],
    [#text(rgb("#d39e00"))[Webseite-Keyring]], [Die Idee ist, dass die Phishing-Landing-Page einen Schlüssel vom Client verlangt, ohne dem der Phishing-Inhalt nicht angezeigt wird -- der Schlüssel wird dem Phishing-Server als ein HTTP-Parameter geschickt @maldev-academy-course-2026[Modul 51].],
    [#text(rgb("#d39e00"))[GoPhish Default-Keyring]], [GoPhish verwendet den `rid`-Parameter als Schlüssel für Phishing-Webseiten. Wichtig ist feztzustellen, dass diesen HTTP-Parameter mittlerweile zahlreiche Sicherheitsscanner erkennen können. Aus diesem Grund ist es allen Phishing-Infrastruktur-Betreiber empfohlen, diesen Schlüsselnamen zu wechseln @sprocketsecurity-gophish-evasion.],
    [#text(rgb("#d39e00"))[Incognito-Modus]], [Es ist davon auszugehen, dass Zielpersonen Webseiten in der Regel nicht im Incognito-Modus öffnen. Sollte das trotzdem erfolgen, so könnte dies als Hinweis gewertet werden, dass die Phishing-Webseite zur Analyse unterzogen wurde @maldev-academy-course-2026[Modul 57].],
    [#text(rgb("#d39e00"))[Reverse DNS-Query]], [Mit einer PTR-DNS-Anfrage kann die IP-Adresse überprüft werden, um herauszufinden, ob ein bestimmter Hostname mit der IP-Adresse assoziiert ist. Falls ein Hostname Text aus der Blackliste enthält, sollte der Client auf eine HTTP-404-Seite weitergeleitet werden. Eine Blackliste könnte folgende Einträge umfassen: `amazonaws`, `google`, `microsoft`, etc @maldev-academy-course-2026[Modul 92].],
    [#text(rgb("#d39e00"))[Shortcut-Erkennung]], [Im Falle einer Interaktion mit einer Phishing-Webseite, sind bestimmte Aktionen zu erwarten, während andere hervorstehen. Da die durchschnittliche Zielperson die Entwicklertools nicht öffnen würde, kann eine Phishing-Webseite nach der Tastenkombination `Ctrl + Shift + I` (Windows) bzw. `Command + Option + I` filtern @maldev-academy-course-2026[Modul 68].],
    [#text(rgb("#d39e00"))[Tastenschreibgeschwindigkeit]], [Automatisierte Scanner zeichnen sich durch eine deutlich höhere Schreibgeschwindigkeit aus als ein durchschnittlicher Mensch. Anhand dieser Information können Scanner identifiziert werden @maldev-academy-course-2026[Modul 68].],
    [#text(rgb("#d39e00"))[Kursorgeschwindigkeit]], [Mithilfe von JavaScript besteht die Möglichkeit, eine Logik zu schreiben, die in der Lage ist, unmenschliche Kursorgeschwindigkeiten zu identifizieren. Diese Technik erweist sich als effektiv bei der Identifizierung von Bots @maldev-academy-course-2026[Modul 68].],
    [#text(red)[JA4+ _Fingerprinting_]], [JA4+ ist ein Paket von Netzwerk-_Fingerprinting_-Methoden, mit denen sich TLS-Konfigurationen von Clients und Server analysieren lassen. Diese Technologie analysiert den TLS-_Handshake_, d.h. die Pakete `ClientHello`, `ServerHello` und weitere _Handshake_-Pakete, um verdächtige Muster zu erkennen; oft verwenden Sicherheitsscanner berechenbare TLS-Konfigurationen @maldev-academy-course-2026[Modul 68].],
  ),
)