%rebase base
<h1>Kurs erstellen</h1>
<form action="./change" method="post" accept-charset="utf-8" enctype="multipart/form-data">
  <input name="num" type="hidden" value="{{kur.num}}">
  Klasse:<input name="name" type="text" size="20" maxlength="40"><br>
  Fach:<input name="fach" type="text" size="20" maxlength="40"><br>
  Oberstufe:<input name="oberstufe" type="checkbox"> (Noten von 0 bis 15, nicht mehr veränderbar)<br>
  Bemerkungen:<br>
  <textarea name="bemerkung" type="text" cols="30" rows="4">{{kur.bemerkung}}</textarea><br>
  <br />
  Schüler mit csv-Datei automatisch anlegen (optional)<a href="/help#csvfile"><img src="/static/info.png" alt="info"> (Bitte Lesen!)</a><br />
  <input type="file" name="csvfile" /><br />
  Bilder aus zip-Datei automatisch zuordnen (optional)<a href="/help#picfile"><img src="/static/info.png" alt="info"> (Bitte Lesen!)</a><br />
  <input type="file" name="picfile" /><br />
  <br />
  <input type="submit" value=" Speichern ">
</form>
<br>
Schüler im Kurs:<br>
%for sch in kur.schueler:
    <a href = "../schueler/{{sch}}">{{sch.bez()}}</a><br>
%end
