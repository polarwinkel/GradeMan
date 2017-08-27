%rebase base
<font color=red>
<h1>Schüler aus Kurs <a href="/kurs/{{kur}}">{{kur.bez()}}</a> entfernen</h1>
Schüler durch Anklicken dem Kurs entfernen.<br>
<b>Achtung:</b> Der Schüler wird <i>sofort</i> entfernt!<br>
%for sch in schueler:
    %if sch in kur.schueler:
        <a href = "/delete/kursschueler/{{kur}}/{{sch}}">{{sch.bez()}}</a><br>
    %end
%end
