%rebase base
<h1>Curriculum <a href="/kurs/{{kur.num}}">{{kur.bez()}}</a></h1>
%for i in range(len(stunden)):
    %if (stunden[i].kurs == kur) and (stunden[i].deleted==False):
        %if stunden[i].faktor == '0':
            <h3 style="color:#a00;">
        %else:
            <h3>
        %end;
        {{stunden[i].datum}}:
        <a href="../stunde/{{stunden[i]}}">{{stunden[i].thema}}</a></h3>
        <pre width="65" style="text-align:left;">{{stunden[i].bemerkung}}</pre>
    %end
%end
