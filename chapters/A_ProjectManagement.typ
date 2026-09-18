#import "@preview/gantty:0.5.1": gantt

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

#lorem(30) You could use the `timeliney` or `gantty` package if you want to
create a time table.

== Difficulties

#lorem(40)
