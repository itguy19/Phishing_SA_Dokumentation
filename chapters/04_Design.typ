#import "@preview/ost-ifs-thesis:1.0.0": styled-table
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes.diamond

= Design

== Infrastruktur

=== Technologien

GoPhish

Azure

Cloudflare Workers

Ansible

#pagebreak()

=== Konzeption

Die simpelste und minimalste Infrastruktur für eine Phishing-Simulation erfordert nur ein einziger öffentlich zugänglicher Server mit GoPhish installiert. In diesem Fall, wie in @einfache-infrastruktur demonstriert, erhält der Server `G` mit einem SSL-Zertifikat den Domain `login.fakemicrosoft.com`, damit die Verbindung für die Zielperson `A` oder `B` als sicher erscheint. 

#figure(
  image("/assets/vereinfachte-phishing-infrastruktur.png"),
  caption: [
    Einfache Infrastruktur.
  ],
) <einfache-infrastruktur>

Somit kann eine Phishing-Simulation von Server `G` gestartet werden, die Phishing-E-Mails werden den Zielpersonen ausgeschickt und die Landing-Page über einem Link veröffentlicht. Die Phishing-Simulation funktioniert und die Zielpersonen erreichen somit die bösartige Landing-Page. 

Mit diesem einzelnen Server `G` können auch bei mehreren Firmen paralell eine Simulation laufen, da mehrere Domains auf die IP-Adresses des Servers zeigen können. 

Dieses minimale Setup weist jedoch grundsätzliche Limitationen und Probleme auf. Falls Zielperson `A` die Landing-Page als ein Phishing-Versuch erkennt und den entsprechenden Kanälen diese auch meldet, lernen daraus eine Überfülle von Sicherheitsscanner schnell, dass dieser Server und deren IP-Adresse als Phishing eingestuft werden soll. Das ist ein Problem, da der GoPhish-Server mit deren Datenbank jetzt neu aufgesetzt werden muss, damit die verschiedenen Pentester ihre Kontos und Projekte auch auf der neuen Instanz einsehen können. Ohne diese Neuaufsetzung des Servers werden zukünftige Phishing-Simulationen funktionunfähig, da Sicherheitsscanner den Server schon kennen. Für die Erkennung des Phishing-Servers ist die Meldung einer Zielperson nicht mal erforderlich. Allein Crawler und Bots können die Phishing-Landing-Page entdecken und melden -- das reicht. Dank den vorher aufgelisteten Tatsachen und der beschriebenen Infrastruktur konnten wir somit etablieren, dass dieser einfache Ansatz für in einer Produktion laufenden Phishing-Simulation nicht ausreichend ist. Wir benötigen eine fortgeschrittene Infrastruktur.

Für diese Arbeit wird die in @fortgeschrittene-infrastruktur gezeigte Infrastruktur eingesetzt. Verglichen mit der einfachen Infrastruktur von vorher, agieren hier Reverse-Proxies als Middle-Man zwischen den Zielpersonen und dem tatsächlichen produktiven GoPhish-Server `G`, sodass die Zielpersonen keinen direkten Kontakt mit Server `G` haben. Dieses Setup geniesst den Vorteil, dass bei einer allfälligen Erkennung der Phishing-Landing-Page nur die Proxy blockiert wird und nicht der dahinter stehende GoPhish-Server `G`. Bei diesem Setup wird pro Kunde eine Reverse-Proxy mit einem einem Domain und SSL-Zertifikat erstellt, welche den Verkehr dem GoPhish-Server weiterleiten. Diese Strategie dient dazu, dass die Infrastruktur projektübergreifend kein Single Point of Failure (SPF) hat, indem eine Reverse-Proxy den Verkehr von allen Kunden weiterleitet. Falls die Reverse-Proxy `R1` als Phishing oder bösartig von Systemen eingestuft wird, wird der Domain und die Reverse-Proxy von Firma `A` verbrannt, kann die Phishing-Simulation von Firma `B` jedoch ohne einfliessende Effekte weiterlaufen.

#figure(
  image("/assets/phishing-infrastruktur-bild.png"),
  caption: [
    Fortgeschrittene Infrastruktur mit Revere-Proxies.
  ],
) <fortgeschrittene-infrastruktur>



=== Aufteilung der Verantwortungsbereichen

=== GoPhish-Härtung

GoPhish ist ein extrem verbreitetes Phishing-Framework, das von vielen Penetration-Testing-Teams weltweit eingesetzt wird. Dank der Popularität erwarten jedoch Blue-Teams die typische Signaturen von einer GoPhish-Phishing-Simulation und können somit die Phishing-Landing-Pages erkennen und entsprechend reagieren @coffsec-enterprise-email-security-gophish.

Um den Erfolg der Simulation zu gewährleisten und um eine allfällige Detektion von diesen Signaturen zu vermeiden, wird bei der Aufsetzung der Phishing-Infrastruktur GoPhish gehärtet und teils umkonfiguriert. Dazu wird ein Skript von GitHub (https://github.com/0xqrx/gophish_customization) verwendet, welches auf einem Blogbeitrag von Sprocket Security @sprocketsecurity-gophish-evasion basiert ist und die folgenden Teile im Source-Code verändert:


#figure(
  caption: [],
  styled-table(
    columns: (4.3cm, 1fr),
    header: ("Name", "Beschreibung"),

    [RID Länge], [Steht für "Recipient ID". Dieser Wert wird pro Zielperson generiert, damit GoPhish individuell diese tracken kann. Standardmässig ist die Länge dieses Wertes 7 und ist ein alfanumerischer String. Bei dieser Arbeit wird die Länge auf 14 hochgeschraubt.],
    [Empfänger-Parameter], [Dieser Parameter heisst standardmässig `rid`. Dieser Parameter gehört zu dem Phishing-Link, der an einer Zielperson geschickt wird und sieht folgendermassen aus: `https://x.y/?rid=s81k081`. `rid` ist ein eindeutiges Zeichen für GoPhish und wird wegen dem zu `openaccess` umbenannt.],
    [Kontakt-Header], [Der Kontakt-Header in einem von GoPhish gesendeten E-Mails heisst standardmässig `X-Gophish-Contact`. Dieser Name wird zu `X-Secure-Contact` umbenannt.],
    [Signatur-Header], [Ähnlich wie beim Kontakt-Header wird der Header `X-Signature-Header` auch umbenannt zu `X-Access-Token`],
  ),
)


#set align(center);
/*
#diagram(
	node-stroke: 1pt,
	node((0,0), [Zielperson mit validem Token], corner-radius: 5pt),
	edge("-|>"),
  node((1,0), [Security Researcher], corner-radius: 5pt),
  edge("-|>"),
	node((2,0), [Automatisierter Scanner], corner-radius: 5pt),
	edge("-|>"),
	node((1,1), align(center)[
		Reverse-Proxy
	], shape: diamond, height: 15),
)
*/

#set align(left)


#pagebreak()

== Phishing-Landing-Page

=== Design

Die Phishing-Landing-Page ist der zentrale Komponente einer Phishing-Kampagne, weswegen es eine äusserste Priorität ist, diese adäquat zu designen. Da in dieser Arbeit Microsoft nachgeahmt wird, muss die Microsoft-Login-Seite als Inspiration genommen werden. Dabei ist es wichtig zu beachten, dass aus Signatur-Gründen die Microsoft-Login-Seite nicht einfach geklont und gehostet werden darf. Ansonsten werden Sicherheitscanner die Phishing-Landing-Page dieser Arbeit blitzschnell anhand der Signaturen erkennen können.

Ein Microsoft-Login erfolgt in genau zwei Schritten: Die Eingabe der E-Mail-Adresse in @schritt-1-microsoft-login und die Eingabe des Passworts in @schritt-2-microsoft-login. 

In @schritt-1-microsoft-login werden zwei weisse Karten vertikal vor einem spannend stilisierten Hintergrundbild angezeigt. Auf der ersten Karte steht ein leeres Feld für die E-Mail-Adresse des Benutzers, darunter andere Optionen wie "No account? Creation one!" oder "Can't access your account?". Diese Texte sind so spezifisch für Microsoft, dass sie für die Phishing-Landing-Page geändert werden müssen. Auf der zweiten Karte unten steht ein Schlüssel mit dem Text "Sign-in options" als eine Möglichkeit.

#figure(
  image("/assets/schritt-1-microsoft-login.png", width: 100%),
  caption: [
    Originale Microsoft-Login-Seite (1/2), Zoom: 250%, Stand 16.11.2026.
  ],
) <schritt-1-microsoft-login>

Beim Schritt zwei wird der Benutzer aufgeboten, das zur E-Mail-Adresse gehörende Passwort einzugeben. Hierbei wird nur eine einzige Karte mit der vorher eingegebenen E-Mail-Adresse in einer abgerundeten Box, ein leerest Passwortfeld und der Text "Other ways to sign in" angezeigt.

#figure(
  image("/assets/schritt-2-microsoft-login.png", width: 100%),
  caption: [
    Microsoft-Login-Seite (2/2), Zoom: 250%, Stand 16.11.2026.
  ],
) <schritt-2-microsoft-login>

Bei beiden Abbildungen gibt es Knöpfe, die zur Navigation dienen: Entweder "Back", "Next" oder ein links-zeigender Pfeil.

Ziel ist es, Basierend auf @schritt-1-microsoft-login und @schritt-2-microsoft-login eine sehr ähnliche, aber trotzdem leicht unterschiedliche Phishing-Landing-Page zu erstellen, die Fähig ist, Sicherheitsscanner zu täuschen. Die typische visuelle sowie textbasierte Signaturen sollten somit umgangen werden, wobei der standardmässige Benutzer auf dem ersten Blick diese Unterschiede nicht erkennen sollte. Das Entwicklungs-Motto der Landing-Page lautet somit: *"Ähnlich, jedoch nicht identisch."*

#pagebreak()

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

Die Listen basieren auf dem Kurs von mr.d0x et al. @maldev-academy-course-2026 und enthält für diese Arbeit relevante Strategien, von denen beim Endprodukt eine Kombination der Strategien angewandt wird.

#pagebreak()

=== Bot-Abwehr Strategien

Komplexität der Implementation: #text(rgb("#0a7900"))[Niedrig], #text(rgb("#d39e00"))[Mittel], #text(red)[Hoch].

#figure(
  caption: [Liste von Bot-Abwehr Massnahmen.],
  styled-table(
    columns: (4.3cm, 1fr),
    header: ("Name", "Beschreibung"),

    [#text(rgb("#0a7900"))[IP-Blocking]], [],
    [#text(rgb("#0a7900"))[Geoblocking]], [Basierend auf der IP-Adresse kann der Standort des Clients ermittelt werden. Falls während einer Phishing-Simulation eines Schweizer Unternehmens ein ausländischer Client versucht, die Phishing-Landing-Page zu erreichen, ist dieser zu blockieren; es ist davon auszugehen, dass es sich um einen Bot handelt.],
    [#text(rgb("#0a7900"))[TLD-Wahl]], [Es wird empfohlen, eine weltweit anerkannte TLD wie `.com`, `.org` oder `.net` zu wählen, damit eine Landing-Page nicht ungewollt blockiert wird.],
    [#text(rgb("#0a7900"))[Domain-Wahl]], [Die Firma des Phishing-Simulation-Kunden sollte nicht in der Second-Level-Domain registriert werden. Es wird empfohlen, die Firma in der Subdomain zu verwenden, da viele Drittanbieter die Firma des Kunden in der Subdomain für den Kunden hosten. Beispiel: Der Drittanbieter Safehosting AG hostet für BigMug AG unter der Domain `bigmug.safehosting.com`.],
    [#text(rgb("#0a7900"))[Domain Add-ons]], [Die Dauer der registrierten Domains sollte nicht länger als ein Jahr sein, da Domains meistens viel schneller verbrannt werden. Das Privacy-Add-on muss unbedingt mit der Domain gekauft werden; der Kauf verhindert, dass persönliche Informationen des Domain-Käufers im Domain-Registrar für die Öffentlichkeit zugänglich werden.],
    [#text(rgb("#0a7900"))[Reputation des Domains]], [Es soll sichergestellt werden, dass die ausgewählte, aber noch nicht gekaufte Domain eine gute Reputation hat. Dazu können Tools wie Whois-History, VirusTotal, URLScan.io und die WaybackMachine verwendet werden.],
    [#text(rgb("#0a7900"))[Wildcard-Zertifikat]], [Wildcard-Zertifikate erhöhen die OPSEC, da sie für automatisierte Scanner das Auffinden von Subdomains erschweren. In den _Certificate-Transparency_-Logs (CT-Logs) wird ein Wildcard-Zertifikat als `*.domain.com` gespeichert. Das bedeutet: Automatisierte Scanner können aus den CT-Logs keine Subdomains erfahren. Für die Entdeckung einer Subdomain müsste ein Scanner aktiv suchen und hoffen, dass es einen Treffer gibt @maldev-academy-course-2026[Modul 13].],
    [#text(rgb("#0a7900"))[Serversicherheit]], [Damit Bots eine Phishing-Webseite nicht als bösartig einstufen, müssen wir sicherstellen, dass HTTP-Zugriffe und direkte IP-Zugriffe verboten sind; Server-Informationen über HTTP-Header nicht freigegeben werden; und der _SSH-Verbose-Banner_ ausgeschaltet ist @maldev-academy-course-2026[Modul 23].],
    [#text(rgb("#0a7900"))[Bot User-Agents]], [Anhand von bekannten User-Agents wie `curl` können triviale Bots detektiert und blockiert werden @maldev-academy-course-2026[Modul 39].],
    [#text(rgb("#0a7900"))[Referrer-Policy]], [Falls die Phishing-Landing-Page nach erfolgreichem _Credential-Capturing_ den Client zur legitimen Login-Webseite weiterleitet, muss sichergestellt werden, dass die Referrer-Policy auf "no-referrer" gesetzt ist. Andernfalls könnte es der Zielfirma auffallen, dass auffällig viel _Traffic_ vom der Phishing-Domain stammt @maldev-academy-course-2026[Modul 34].],
    [#text(rgb("#d39e00"))[Reverse-Proxy in der #linebreak() Allowlist]], [Damit der Phishing-Server von extern nicht gescannt wird, darf nur die IP-Adresse des Reverse-Proxys über HTTPS mit dem Server kommunizieren. Ein direkter Zugriff auf die Inhalte des Phishing-Servers soll nicht möglich sein @maldev-academy-course-2026[Modul 30].],
    [#text(rgb("#d39e00"))[Headless-Browsers]], [Viele automatisierte Bots verwenden einen _Headless-Browser_, um Webseiten zu scannen. Anhand des `navigator.webdriver`-JavaScript-Objekts kann im Code herausgefunden werden, ob der Client einen _Headless-Browser_ verwendet oder nicht. Im positiven Fall, kann der Client blockiert oder zur legitimen Webseite weitergeleitet werden @maldev-academy-course-2026[Modul 38].],
    [#text(rgb("#d39e00"))[Manipulierte #linebreak() User-Agents]], [Bei Bots ist es trivial, den User-Agent zu manipulieren, damit er als ein legitimer Client aussieht. Auf der Phishing-Webseite kann das `navigator.userAgent`-Objekt verwendet werden, um mit dem `User-Agent` vom Header zu vergleichen; falls die beiden nicht den gleichen Wert haben, wurde der Header manipuliert @maldev-academy-course-2026[Modul 40].],
  ),
)

#pagebreak()

=== Analyseerschwerung

#figure(
  caption: [Liste von Analyseerschwerenden Massnahmen.],
  styled-table(
    columns: (auto, 1fr),
    header: ("Name", "Beschreibung"),
    [#text(rgb("#0a7900"))[File-Extension-Spoofing]], [Es besteht keine zwingende Notwendigkeit, JavaScript-Code direkt in einem `.js`-File zu speichern; andere Extensions wie `.css` oder `.woff` können auch JavaScript-Code beinhalten, erfolgreich in einem HTML-File geladen und ausgeführt werden @maldev-academy-course-2026[Modul 48].],
    [#text(rgb("#d39e00"))[Dynamische HTML-Generierung]], [Die Inhalte der Phishing-Webseite können mit JavaScript dynamisch generiert werden, damit statische Scanner Schwierigkeiten haben, die Webseite als Phishing einzustufen @maldev-academy-course-2026[Modul 42].],
    [#text(rgb("#d39e00"))[Code-_Obfuscation_]], [Um die Analyse der Phishing-Webseite zu erschweren, können verschiedene Verfahren zur Codierung oder Verschlüsselung der Inhalte, wie Base64, XOR, AES oder weitere Methoden verwendet werden. Diese Massnahme trägt zur Reduzierung der Phishing-Detektionsraten bei @maldev-academy-course-2026[Modul 43,44,45].],
    [#text(rgb("#d39e00"))[Zero-Width Obfuscation]], [Hierbei handelt es um eine unsichtbare Codierug, die dabei helfen kann, Sicherheitsscanner zu umgehen. @maldev-academy-course-2026[Modul 93]],
    [#text(rgb("#d39e00"))[Externe Dateien]], [Um die Übersicht zu wahren und Detektionsversuchen zu verhindern, ist es von Vorteil, wenn JavaScript nicht direkt in `index.html` gespeichert ist, sondern in einem externen File @maldev-academy-course-2026[Modul 48].],
    [#text(rgb("#d39e00"))[Inhaltscamouflage]], [Um den Inhalt einer JavaScript-Datei weniger auffällig zu machen, kann vor der Phishing-Logik legitimer Code stehen, damit die Datei auf dem ersten Blick als legitim erscheint. @maldev-academy-course-2026[Modul 48]],
    [#text(rgb("#d39e00"))[Populäre JavaScript-Bibliotheken #linebreak() Modifizieren]], [Falls Phishing-JavaScript-Code in populäre JavaScript-Bibliotheken eingebettet und versteckt wird, reduziert sich die Wahrscheinlichkeit einer Erkennung @maldev-academy-course-2026[Modul 48].],
    [#text(rgb("#d39e00"))[Webseite-Keyring]], [Die Idee ist, dass die Phishing-Landing-Page einen Schlüssel vom Client verlangt, ohne dem der Phishing-Inhalt nicht angezeigt wird -- der Schlüssel wird dem Phishing-Server als ein HTTP-Parameter geschickt @maldev-academy-course-2026[Modul 51].],
    [#text(rgb("#d39e00"))[GoPhish Default-Keyring]], [GoPhish verwendet den `rid`-Parameter als Schlüssel für Phishing-Webseiten. Wichtig ist feztzustellen, dass diesen HTTP-Parameter mittlerweile zahlreiche Sicherheitsscanner erkennen können. Aus diesem Grund ist es allen Phishing-Infrastruktur-Betreiber empfohlen, diesen Schlüsselnamen zu wechseln @sprocketsecurity-gophish-evasion.],
    [#text(rgb("#d39e00"))[Incognito-Modus]], [Es ist davon auszugehen, dass Zielpersonen Webseiten in der Regel nicht im Incognito-Modus öffnen. Sollte das trotzdem erfolgen, so könnte dies als Hinweis gewertet werden, dass die Phishing-Webseite zur Analyse unterzogen wurde @maldev-academy-course-2026[Modul 57].],
    [#text(rgb("#d39e00"))[Reverse DNS-Query]], [Mit einer PTR-DNS-Anfrage kann die IP-Adresse überprüft werden, um herauszufinden, ob ein bestimmter Hostname mit der IP-Adresse assoziiert ist. Falls ein Hostname Text aus der Blackliste enthält, sollte der Client auf eine HTTP-404-Seite weitergeleitet werden. Eine Blackliste könnte folgende Einträge umfassen: `amazonaws`, `google`, `microsoft`, etc @maldev-academy-course-2026[Modul 92].],
    [#text(rgb("#d39e00"))[Tastenshortcuts-Erkennung]], [Im Falle einer Interaktion mit einer Phishing-Webseite, sind bestimmte Aktionen zu erwarten, während andere hervorstehen. Da die durchschnittliche Zielperson die Entwicklertools nicht öffnen würde, kann eine Phishing-Webseite nach der Tastenkombination `Ctrl + Shift + I` (Windows) bzw. `Command + Option + I` filtern @maldev-academy-course-2026[Modul 68].],
    [#text(rgb("#d39e00"))[Tastenschreibgeschwindigkeit]], [Automatisierte Scanner zeichnen sich durch eine deutlich höhere Schreibgeschwindigkeit aus als ein durchschnittlicher Mensch. Anhand dieser Information können Scanner identifiziert werden @maldev-academy-course-2026[Modul 68].],
    [#text(rgb("#d39e00"))[Kursorgeschwindigkeit]], [Mithilfe von JavaScript besteht die Möglichkeit, eine Logik zu schreiben, die in der Lage ist, unmenschliche Kursorgeschwindigkeiten zu identifizieren. Diese Technik erweist sich als effektiv bei der Identifizierung von Bots @maldev-academy-course-2026[Modul 68].],
    [#text(red)[JA4+ _Fingerprinting_]], [JA4+ ist ein Paket von Netzwerk-_Fingerprinting_-Methoden, mit denen sich TLS-Konfigurationen von Clients und Server analysieren lassen. Diese Technologie analysiert den TLS-_Handshake_, d.h. die Pakete `ClientHello`, `ServerHello` und weitere _Handshake_-Pakete, um verdächtige Muster zu erkennen; oft verwenden Sicherheitsscanner berechenbare TLS-Konfigurationen @maldev-academy-course-2026[Modul 68].],
  ),
)
