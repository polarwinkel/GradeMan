%rebase base
<h1>Schülerliste</h1>
Aktionen:<br>
<a href = "./new">Neuen Schüler erstellen</a><br>
<br>
Liste aller existierender Schüler:<br>
%for sch in schueler:
    %if sch.deleted==False:
        <a href = "./{{sch}}">{{sch.bez()}}</a><br>
    %end
%end
