%rebase base
<h1>Datenverwaltung</h1>
<div class="pagemenu">
<a href="/schueler/all">Schülerliste</a> | 
<a href="/schueler/new">neuer Schüler</a> | 
<a href = "/kurs/new">Neuer Kurs</a> | 
<a href="/stunde/all">Stundenliste anzeigen</a>
</div>
<h2>Schüler</h2>
<a href="/schueler/all">Schülerliste anzeigen</a><br>
<a href="/schueler/new">neuen Schüler hinzufügen</a><a href="/help#schueleradd"><img src="/static/info.png" alt="info"></a><br>
<br>
<a href="/lernnamen/all">Alle Namen lernen</a><br>
<br>
<h2>Kurse</h2>
<a href = "/kurs/new">Neuen Kurs erstellen</a><br>
<br>
Vorhandene Kurse:<br>
%for kur in kurse:
    %if kur.deleted==False:
        <a href = "kurs/{{kur}}">{{kur.bez()}}</a><br>
    %end
%end
<br>
<h2>Stunden</h2>
<a href="/stunde/all">Stundenliste anzeigen</a><br>
<br>
<h2><span style="color: #f00">Löschen</span></h2>
<a href="/delete"><span style="color: #f00">Einträge löschen</span></a><br>
