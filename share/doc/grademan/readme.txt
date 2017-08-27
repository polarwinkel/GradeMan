========
GradeMan
========
GradeMan ist ein Ansatz, um die Papierlisten (Anwesenheit, Noten, ...) 
im Lehreralltag zu digitalisieren und zu automatisieren.

GradeMan bietet darüber hinaus aber auch weitere Funktionen wie einen 
Assistenten zum lernen der Schülernahmen oder Auswertfunktionen der 
eingegebenen Daten.

Einfach die Datei GradeMan oder GradeMan.exe starten. GradeMan ist dann im Browser unter
http://localhost:8084/
erreichbar!

Alle Daten werden in der automatisch erzeugten db.pickle gespeichert. 
Zum neuen Schuljahr einfach die alte Datei verschieben/umbenennen! Oder 
die neue GradeMan-Version unter http://grademan.polarwinkel.de herunterladen!

Bei Fragen hilft vielleicht die Webseite zum Projekt weiter:
http://grademan.polarwinkel.de/
Wenn hier keine Hilfe zu finden ist, Sie einen Fehler gefunden oder 
einen Vorschlag zur Verbesserung haben freue ich mich auf eine eMail:
it@polarwinkel.de

GradeMan steht unter der AGPL-Lizenz (siehe licence.txt).

Erste Schritte
==============
* Starte den GradeMan-Server (s.o.).
* Klicke auf der Startseite auf "Datenverwaltung" und dann auf "Neuen Kurs erstellen".
* Kurse können aus csv-Dateien automatisch erstellt werden, Schülerbilder aus einer zip-Datei automatisch hinzugefügt werden.
* Schüler können auch manuell erstellt werden und in der Kursansicht mit "Schüler dem Kurs hinzufügen" eingefügt werden.

* Jetzt kann eine Stunde für den Kurs erstellt werden ("neue Stunde" im grünen top-Menü).
* In der Stundenansicht kann die Anwesenheit und die Bewertung für die Stunde entweder mit dem Teilnahmeassistenten oder per Liste ("Alle Teilnahmen ändern") eingegeben werden.
* In der Kursübersicht kann zum Beispiel über die "Schülerübersicht" die Auswertungsseite für einen bestimmten Schüler aufgerufen werden.

* Jetzt kennst du die wesentlichen Funktionen von GradeMan!

Ich wünsche entspanntes Arbeiten damit!

Bei Fehlern
===========
GradeMan prüft die Datenbank bei jedem Start auf Fehler und sichert dann die Datenbank in der Datei db.bak.
Wenn der GradeMan-Server nicht startet könnte das an einer defekten Datenbank liegen.
Sollte die GradeMan-Datenbank aus irgend welchen Gründen beschädigt sein (z.B. Systemabsturz während des speicherns)
kann der Zustand beim letzten Start wieder hergestellt werden, indem die Datei db.pickle entfernt wird und die Datei db.bak in db.pickle umbenannt wird!

Weitere Hilfe ist unter http://grademan.polarwinkel.de/ zu finden.
