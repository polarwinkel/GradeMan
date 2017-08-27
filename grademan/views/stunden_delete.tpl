%rebase base
<font color=red>
<h1>Stunde löschen</h1>
Auf die zu löschende Stunde klicken.<br>
<br>
%for stu in stunden:
    %if stu.deleted==False:
        <a href = "/delete/confirm/stunde/{{stu}}">{{stu.kurs.bez()}} {{stu.datum}}: {{stu.thema}}</a><br>
    %end
%end
</font>
