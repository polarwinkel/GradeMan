%rebase base
<h1>Namen lernen</h1>
Kurs auswählen:<br>
<br>
%for kur in kurse:
    %if kur.deleted==False:
        <a href = "/lernnamen/{{kur}}">{{kur.bez()}}</a><br>
    %end
%end
