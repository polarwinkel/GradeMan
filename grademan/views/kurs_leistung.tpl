%rebase base
<h1>Leistungsübersicht <a href="/kurs/{{kur.num}}">{{kur.bez()}}</a></h1>

<p>Zusammenfassung<br>
(Durchschnittsleistungen, Gesamtfehlzeiten)</p>
<table style="border:2px solid silver; background-color:#fff;font-size:small;" rules="all"><tr>
<td>Stunde<br>(Datum,Faktor)</td>
%i=0
%for sch in kur.schueler:
    <td style="line-height: 0.9em; text-align:center; text-decoration:none; min-width:1em;">
    %try:
        %for element in sch.vorname.decode('utf_8'):
            <a href="/kursschueler/{{kur.num}}/{{sch}}" style="text-decoration:none;">{{element}}</a><br>
        %end
    %except:
        TODO: Zeichensatzfehler! Sorry, bitte <a href="mailto:online@polarwinkel.de">Fehlermeldung an Dirk (Entwickler)</a>, mit Angabe des Betriebssystem, danke!
    %end
    </td>
%end
</tr>

<tr><td><b>1. Halbjahr</b></td></tr>
<tr><td>Fachlich</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][0][0]}}</td>
%end
</tr>
<tr><td>Mitarbeit</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][0][1]}}</td>
%end
</tr>
<tr><td>Fehlstunden</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][0][2]}}</td>
%end
</tr>
<tr><td>Unentschuldigt</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][0][3]}}</td>
%end
</tr>
<tr><td>Hausaufgaben</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][0][4]}}</td>
%end
</tr>

<tr><td><b>2. Halbjahr</b></td></tr>
<tr><td>Fachlich</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][1][0]}}</td>
%end
</tr>
<tr><td>Mitarbeit</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][1][1]}}</td>
%end
</tr>
<tr><td>Fehlstunden</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][1][2]}}</td>
%end
</tr>
<tr><td>Unentschuldigt</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][1][3]}}</td>
%end
</tr>
<tr><td>Hausaufgaben</td>
%for i in range(len(leistung)):
    <td>{{leistung[i][1][4]}}</td>
%end
</tr>

<tr><td><b>Sonderstunden</b></td></tr>
<tr>
%for znum in range(len(teilntabelle)):
    <tr>
    %if stunden[znum].faktor == '0':
        <td><a href="/stunde/{{stunden[znum].num}}" style="color:#a00;">{{stunden[znum].thema}}</a></td>
        %for snum in range(len(teilntabelle[0])):
            <td>
            %if teilntabelle[znum][snum]:
                {{teilntabelle[znum][snum].fachlich}}/{{teilntabelle[znum][snum].mitarbeit}}
            %end
            </td>
        %end
    </tr>
    %end
%end
</table>
<br>

<p>Notenübersicht<br>
(Bedeutung: Fachlich/Mitarbeit)</p>
<table style="border:2px solid silver; background-color:#fff;font-size:small;" rules="all"><tr>
<td>Stunde<br>(Datum,Faktor)</td>
%i=0
%for sch in kur.schueler:
    <td style="line-height: 0.9em; text-align:center; text-decoration:none;">
    %try:
        %for element in sch.vorname.decode('utf_8'):
            <a href="/kursschueler/{{kur.num}}/{{sch}}" style="text-decoration:none;">{{element}}</a><br>
        %end
    %except:
        TODO: ungelöster Zeichensatzfehler!
    %end
    </td>
%end
</tr>
%for znum in range(len(teilntabelle)):
    <tr>
    %if stunden[znum].faktor == '0':
        <td><a href="/stunde/{{stunden[znum].num}}" style="color:#a00;">{{stunden[znum].datum}},{{stunden[znum].faktor}}</a></td>
    %else:
        <td><a href="/stunde/{{stunden[znum].num}}">{{stunden[znum].datum}},{{stunden[znum].faktor}}</a></td>
    %end;
    %for snum in range(len(teilntabelle[0])):
        <td>
        %if teilntabelle[znum][snum]:
            {{teilntabelle[znum][snum].fachlich}}/{{teilntabelle[znum][snum].mitarbeit}}
        %end
        </td>
    %end
    </tr>
%end
</table>
<br>

<p>Anwesenheitsübersicht<br>
(Bedeutung: Anwesend/Entschuldigt/Hausaufgaben)</p>
<table style="border:2px solid silver; background-color:#fff;font-size:small;" rules="all"><tr>
<td>Stunde<br>(Datum,Faktor)</td>
%i=0
%for sch in kur.schueler:
    <td style="line-height: 0.9em; text-align:center; text-decoration:none;">
    %try:
        %for element in sch.vorname.decode('utf_8'):
            <a href="/kursschueler/{{kur.num}}/{{sch}}" style="text-decoration:none;">{{element}}</a><br>
        %end
    %except:
        TODO: ungelöster Zeichensatzfehler!
    %end
    </td>
%end
</tr>
%for znum in range(len(teilntabelle)):
    <tr>
    %if stunden[znum].faktor == '0':
        <td><a href="/stunde/{{stunden[znum].num}}" style="color:#a00;">{{stunden[znum].datum}},{{stunden[znum].faktor}}</a></td>
    %else:
        <td><a href="/stunde/{{stunden[znum].num}}">{{stunden[znum].datum}},{{stunden[znum].faktor}}</a></td>
    %end;
    %for snum in range(len(teilntabelle[0])):
        <td>
        %if teilntabelle[znum][snum]:
            {{'✓' if teilntabelle[znum][snum].anwesenheit == True else '✗'}}/
            {{'✓' if teilntabelle[znum][snum].entschuldigt == True else '✗'}}/
            {{'✓' if teilntabelle[znum][snum].hausaufgabe == True else '✗'}}
        %end
        </td>
    %end
    </tr>
%end
</table>
