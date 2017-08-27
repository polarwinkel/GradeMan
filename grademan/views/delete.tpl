%rebase base
<font color=red>
<h1>Eintrag löschen</h1>
Was soll gelöscht werden?<br>
<br>
<a href="/delete/kurs/all">Ein Kurs</a><br>
<br>
<a href="/delete/schueler/all">Ein Schüler</a><br>
<br>
<a href="/delete/stunde/all">Eine Stunde</a><br>
<br>
<br>
Einen oder mehrere Schüler aus folgendem Kurs entfernen:<br>
%for kur in kurse:
    %if kur.deleted == False:
        <a href = "/delete/kursschueler/{{kur}}">{{kur.bez()}}</a><br>
    %end
%end

</font>
