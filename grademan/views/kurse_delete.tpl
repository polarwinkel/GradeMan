%rebase base
<font color=red>
<h1>Kurs löschen</h1>
Auf den zu löschenden Kurs klicken.<br>
<br>
%for kur in kurse:
    %if kur.deleted==False:
        <a href = "/delete/confirm/kurs/{{kur}}">{{kur.bez()}}</a><br>
    %end
%end
</font>
