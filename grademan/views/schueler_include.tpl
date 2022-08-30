%rebase base
<h1>Kurs <a href="/kurs/{{kur}}">{{kur.bez}}</a> füllen</h1>
Schüler durch Anklicken dem Kurs hinzufügen:<br>
%for sch in schueler:
    %if (sch not in kur.schueler) and (sch.deleted==False):
        <a href = "./{{sch}}">{{sch.bez()}}</a><br>
    %end
%end
<br>
<a href="/kurs/{{kur}}">zum Kurs {{kur.bez()}}</a>
