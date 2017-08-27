%rebase base
<font color=red>
<h1>Schüler löschen</h1>
Auf den zu löschenden Schüler klicken.<br>
<br>
%for sch in schueler:
    %if sch.deleted==False:
        <a href = "/delete/confirm/schueler/{{sch}}">{{sch.bez()}}</a><br>
    %end
%end
</font>
