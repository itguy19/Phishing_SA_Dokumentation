= Implementation <implementation>

== Technologien

=== GoPhish

Ein Open-Source-Phishing-Framwork das unter anderen Firmen verbreitet ist und auch beim Praxispartner dieser Arbeit eingesetzt wird. Es ist ein mächtiges, in Go geschriebenes, Tool, welches Pentestern erlaubt, Phishing-Simulationen zu verwalten; E-Mail-Vorlagen und Landing-Pages zu erstellen; geöffnete Phishing-E-Mails zu tracken; sowie Statistiken und Berichte für Kunden-Reports erstellen lässt. Wegen diesen beliebten Features wird dieses Tool oft im Rahmen von Security-Awareness-Trainings sowie Red-Team- oder Pentest-Aufträgen verwendet.   

=== Microsoft Azure

Ein weltweit bekanntes Cloud-Computing-Plattform. Für diese Arbeit wird das "Azure for Students" Angebot von Azure beansprucht, indem die für Studenten kostenlose virtuelle Maschine (Standard B2ats v2, vCPUs: 2, RAM: 1 GiB und Threads per core: 2) für den GoPhish-Server verwendet wird.

=== Ansible

Ein Open-Source-Tool für IT-Automatisierung. Dieses Tool wird mit dem Ziel eingesetzt, die Transparenz der Konfigurationen zu erhöhen und die Reproduzierbarkeit des GoPhish-Servers zu verbessern. Dafür wird für den GoPhish-Server ein Ansible-Playbook geschrieben -- ein Skript, welches die einzelnen Konfigurationsschritte des Servers automatisiert.

=== Cloudflare

Ein digitaler "Türsteher" für Webseiten. Anstatt einen Server direkt ins Internet zu stellen, kann Cloudflares weltweites Netzwerk vor einer Webseite dazwischen geschaltet werden. Für diese Arbeit werden zwei Cloudflare-Technologien verwendet: Workers und Tunneling. Cloudflare Workers agieren als der Eintrittspunkt ins Cloudflare-Netzwerk und können kleine Programme ausführen, um den Internet-Verkehr zu analysieren, und den Verkehr weiterzuleiten. Der Cloudflare-Tunnel ist für die Verbindung zwischen dem Worker und dem GoPhish-Server verantwortlich.

== Überblick des Projekts

=== Aufsetzung und Konfiguration des Reverse-Proxys

=== Entwicklung der Phishing-Landing-Page

=== Einrichtung des GoPhish-Servers



=== Experimente


==== Statistische und dynamische Analyse


==== Live-Analyse


== Beispiel


#figure(
  ```python
  def greet(name: str) -> str:
      return f"Hello, {name}!"


  print(greet("World"))
  ```,
  caption: [Example code.],
)
