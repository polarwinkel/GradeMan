%rebase base
<h1>Hilfe und Dokumentation</h1>
<h2>Einstieg</h2>
<h3>Zweck</h3>
GradeMan ist konzipiert als universelles Hilfsmittel für Lehrer, insbesondere als digitaler Ersatz für Papierlisten, seien es Anwesenheits- oder Notenlisten, aber auch Notizen zur Unterrichtsvorbereitung<br>
<h3>Einrichtung</h3>
Beim ersten Start legt GradeMan automatisch eine neue Datenbank in der Datei db.pickle im Programmverzeichnis an. In dieser liegen alle Daten mit der Ausnahme der Schülerbilder. Es bietet sich an diese von Zeit zu Zeit zu sichern. Bei jedem Start legt GradeMan aber auch eine Sicherungskopie an (und überschreibt damit die ältere), nachdem die Datenbank auf konsistenz überprüft wurde.<br>
Es können dann Schüler, Stunden und Kurse angelegt werden. Kurse können schließlich mit Schülern gefüllt werden. Stunden werden jeweils einem Kurs zugeordnet.<br>
Schülerbilder können in den Unterordner "pictures" abgelegt werden. Wichtig ist es dabei, dass der Dateinahme das Schema "Vorname_Nachname.jpg" befolgt, damit GradeMan es dem jeweiligen Schüler zuordnen kann. Auch die Großschreibung, Leerzeichen, ... sind dabei zu beachten!<br>
In der Schülerübersicht eines Kurses kann durch auswählen eines Schülers dessen automatische Statistik und alle dazugehörigen Teilnahmen betrachtet werden.
<h3>Programmfehler oder Ideen</h3>
Wenn Fehler im Programm auftreten würde ich mich über einen kurzen Fehlerbericht per <a href="mailto:it@polarwinkel.de">eMail</a> freuen! Auch für Ideen für neue Funktionen von GradeMan oder einfach nur ein allgemeines Feedback habe ich immer <strike>ein offenes Ohr</strike> einen offenen Posteingang ;-) !
<h2>Hilfe für einzelne Programmteile (von dort aus verlinkt)</h2>
<h3><a name="schueleradd"></a>Neuen Schüler hinzufügen</h3>
Für jeden Schüler kann ein Schülerfoto hinzugefügt werden. Dieses suche GradeMan im Programmordner "pictures" unter dem Dateinamen "Vorname_Nachname.jpg". Wichtig ist die exakte Schreibweise mit korrekter Groß- und Kleinschreibung, sowie ggf. allen Leerzeichen etc.
<br>
<h3><a name="csvfile"></a>Schüler für Kurs automatisch aus einer csv-Datei importieren</h3>
csv-Dateien lassen sich z.B. aus LibreOffice Calc oder MS Excel exportieren. csv steht dabei für "comma-saparated values", also durch Komma getrennte Werte.<br />
Die csv-Datei für GradeMan muss dabei genau den Aufbau "Nachname, Vorname, Geschlecht (Kleinbuchstabe: m oder w)" in jeder Zeile haben und darf ansonsten nichts beinhalten (keine Spaltenüberschriften o.ä.).<br />
Beispiel:<br />
Müller,Max,m<br />
Beim Export aus dem Tabellenkalkulationsprogramm sollte als Zeichensatz/Codierung "utf-8" gewählt werden, als Feldtrenner ",", als Texttrenner nichts.<br />
Achtung: Alle neuen Namen in der csv-Datei werden als neue Schüler angelegt! Wenn schon welche in exakt gleicher Schreibweise in GradeMan vorhanden sind werden diese dem Kurs zugeordnet.<br />
<br>
<h3><a name="picfile"></a>Bilder automatisch aus zip-Datei einfügen und zuordnen</h3>
Eine .zip-Datei mit Bildern (.jpg) kann angegeben werden. Die Bilder werden in der vorliegenden Reihenfolge den Schülern des Kurses zugeordnet. Falls den Schülern schon Bilder zugeordnet sind werden diese ersetzt.<br />
Wichtig: Wenn die Reihenfolge nicht exakt stimmt, z.B. ein zusätzliches Bild dabei ist oder eins fehlt, wird die Zuordnung natürlich Falsch! Die Idee ist es die Schüler in alphabetischer Reihenfolge zu fotografieren, ist ein Schüler nicht da oder will nicht fotografiert werden sollte z.B. ein Dummyfoto erstellt werden.<br />
<br>
<h3><a name="stundefaktor"></a>Stundenfaktor</h3>
Der Stundenfaktor bezeichnet die Anzahl der Stunden: Eine Doppelstunde hat also den Stundenfaktor 2. Fehlstunden werden so doppelt gewertet, vergessene Hausaufgaben aber natürlich nur einfach.<br>
Ein Stundenfaktor von 0 bezeichnet eine Sonderstunde, wie z.B. eine Klassenarbeit oder Zwischennoten: Die Teilnahmen werden nicht in der Durchschnittsberechnung verwendet, wird in der Leistungsübersicht für einzelne Schüler aber ganz oben angezeigt.
<br>
<h3><a name="teilnahmen"></a>Teilnahmen</h3>
Teilnahmen sind die schülerbezogenen Daten für eine Stunde (bei Stundenfaktor 2: Doppelstunde, ...).<br>
Eingetragen werden kann die <b>A</b>nwesenheit, ob die fehlende Anwesenheit <b>E</b>ntschuldigt ist (Anwesend und Entschuldigt wird bei der Ermittlung unentschuldigter Fehlstunden ignoriert), ob die <b>Ha</b>usaufgaben vorhanden sind, sowie eine <b>F</b>achliche und eine <b>M</b>itarbeitsnote.<br>
Das Feld <b>Bemerkungen</b> nimmt alle weitere relevante Information auf (z.B. Punkzahl bei der Klassenarbeit, besondere Leistungen, ...)
<br>
<h3><a name="kursschueler"></a>Ermittlung der Halbjahresleistungen</h3>
Alle Stunden von August bis Januar zählen zum ersten Halbjahr, alle von Februar bis Juli zum 2. Halbjahr.<br>
Die Fehlstunden sind die Summe aller Stunden wo das <b>A</b>nwesend-Feld deaktiviert wurde. Der Stundenfaktor wird dabei berücksichtigt (z.B. Faktor 2: Zwei Fehlstunden).<br>
Unentschuldigte Fehlstunden sind die, wo gleichzeitig das <b>A</b>nwesend-Feld deaktiviert und das <b>E</b>ntschuldigt-Feld nicht aktiviert ist.<br>
Bei fehlenden <b>Ha</b>usaufgaben wird der Stundenfaktor nicht berücksichtigt.<br>
Die <b>F</b>achliche- und die <b>M</b>itarbeitsnote ist der berechnete Durchschnitt für das Halbjahr unter Berücksichtigung des Stundenfaktors, Gesamt ermittelt daraus wiederum den Durchschnitt (ohne besondere Berücksichtigung wie viele Noten jeweils eingetragen wurden: Mitarbeit und Fachlich zählt immer je 50%).
<br>
<h3>csv-Export für LibreOffice Calc, Excel, ...</h3>
Folgende Datenbestände können als csv-Datei exportiert werden:<br>
<a href="/csv/kurs.csv">Kurse</a><br>
<a href="/csv/schueler.csv">Schüler</a><br>
<a href="/csv/stunde.csv">Stunden</a><br>
<a href="/csv/teilnahme.csv">Teilnahmen</a><br>
Die csv-Datei kann beispielsweise mit LibreOffice Calc importiert werden. Der versierte Nutzer kann so alle Auswertungsmöglichkeiten der Tabellenkalkulation auf den Daten anwenden. Besonders Hilfreich ist dafür warscheinlich der Export der <a href="/csv/teilnahme.csv">Teilnahmen</a>, die anschließend nach Namen, dann nach der Stunde und schließlich nach dem Kurs sortiert werden.
<h3>Lizenz:</h3>
GradeMan steht unter der Lizenz <a href="http://www.gnu.org/licenses/agpl-3.0.html" target="_blank">AGPL v3</a> oder neuer.<br>
Es kann kostenlos <a href="http://polarwinkel.de/index.php?id=76" target="_blank">heruntergeladen</a> oder weitergegeben werden!<br>
Jede Haftung ist jedoch ausdrücklich ausgeschlossen!
