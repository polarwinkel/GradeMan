%rebase base
<h1>Kurs {{kur.bez()}}</h1>
<div class="pagemenu">
<a href="/kursuebersicht/{{kur}}">Schülerübersicht</a> | 
<a href="/kurs/sitzplan/{{kur}}">Sitzplan</a> | 
<a href="/lernnamen/{{kur}}">Namen lernen</a> | 
<a href ="/kursleistung/{{kur}}">Leistungsübersicht</a> | 
<a href="/kurscurriculum/{{kur}}">Curriculum</a><br>
Neue Stunde: <a href="/stunde/new/{{kur}}">Heute</a> | <a href="/stunde/new/{{kur}}/1">Morgen</a> | 
</div>
<form action="./change" method="post" accept-charset="utf-8" enctype="multipart/form-data">
  <input name="num" type="hidden" value = "{{kur.num}}">
  Name:<input name="name" type="text" size="10" maxlength="40" value = "{{kur.name}}">
  Fach:<input name="fach" type="text" size="10" maxlength="40" value = "{{kur.fach}}">
  {{' (Oberstufe)' if kur.oberstufe else ''}}<br>
  <textarea name="bemerkung" type="text" cols="65" rows="6">{{kur.bemerkung}}</textarea><br>
  <br>
  <input type="submit" value=" Speichern ">
</form>
<br><br><br>
Stunden des Kurses:<br>
%for i in range(len(stunden)):
    %if (stunden[i].kurs == kur) and (stunden[i].deleted==False):
        %if stunden[i].faktor == '0':
            <a href="../stunde/{{stunden[i]}}" style="color:#a00;">{{stunden[i].datum}}: {{stunden[i].thema}}</a><br>
        %else:
            <a href="../stunde/{{stunden[i]}}">{{stunden[i].datum}}: {{stunden[i].thema}}</a><br>
        %end
    %end
%end
<br />
<hr />
<br />
Kursliste bearbeiten:<br />
<a href ="./{{kur}}/add/">einzelnen Schüler hinzufügen</a><br />
<br />
<form action="./change" method="post" accept-charset="utf-8" enctype="multipart/form-data">
  <input name="num" type="hidden" value = "{{kur.num}}">
  <input name="name" type="hidden" value = "{{kur.name}}">
  <input name="fach" type="hidden" value = "{{kur.fach}}">
  <input name="bemerkung" type="hidden" value="{{kur.bemerkung}}">
  Schüler mit csv-Datei automatisch anlegen<a href="/help#csvfile"><img src="/static/info.png" alt="info"> (Bitte Lesen!)</a><br />
  <input type="file" name="csvfile" /><br />
  Bilder aus zip-Datei automatisch zuordnen<a href="/help#picfile"><img src="/static/info.png" alt="info"> (Bitte Lesen!)</a><br />
  <input type="file" name="picfile" /><br />
  <br>
  <input type="submit" value=" Speichern ">
</form>
<br />
Kursdaten exportieren (z.B. um sie im nächsten Schuljahr zu importieren):<br />
<a href ="/kurslistenexport/{{kur}}/{{kur.name}}.csv">Kursliste als csv-Datei exportieren</a><br />
<a href ="/kursbilderexport/{{kur}}/{{kur.name}}.zip">Schülerbilder exportieren (als zip-Datei gepackt)</a><br />
