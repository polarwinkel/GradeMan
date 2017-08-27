%rebase base
<h1>Schüler Details</h1>
<h2 style="display:inline;"><a href="/schueler/{{schueler}}">{{schueler.bez()}}</a></h2>
, <a href="/kurs/{{kurs.num}}">{{kurs.bez()}}</a> (Nächster: <a href="{{nsch if nsch!= '' else ''}}">{{nsch.bez() if nsch!= '' else ''}}</a>)<br><br>
<table><tr><td>
<a href="/schueler/{{schueler}}"><img src="/pictures/{{schueler.pic()}}" width="200px"></a>
</td><td>
  Bemerkungen:<br>
  <pre width="45" style="text-align:left;">{{schueler.bemerkung}}</pre><br>
<br>
<h3>Mitarbeit 1. Halbjahr:<a href="/help#kursschueler"><img src="/static/info.png" alt="info"></a></h3>
<table><tr>
    <td>Fehlst.: </td>
    <td><b>{{leistung[0][2]}}</b></td>
    <td> | Unent.: </td><td><b>{{leistung[0][3]}}</b></td>
    <td> | Hausaufgaben: </td><td><b>{{leistung[0][4]}}</b></td>
  </tr><tr>
    <td>Fachlich: </td>
    <td><b>{{str(leistung[0][0])}}</b></td>
    <td> | Mitarbeit:</td>
    <td><b>{{leistung[0][1]}}</b></td>
    <td> | Ø Gesamt: </td>
    <td><b>{{str((float(leistung[0][0])+float(leistung[0][1]))/2) if (leistung[0][0] != '-' and leistung[0][1] != '-') else '-' }}</b></td>
</tr></table>
<h3>Mitarbeit 2. Halbjahr:</h3>
<table><tr>
    <td>Fehlst.: </td>
    <td><b>{{leistung[1][2]}}</b></td>
    <td> | Unent.: </td><td><b>{{leistung[1][3]}}</b></td>
    <td> | Hausaufgaben: </td><td><b>{{leistung[1][4]}}</b></td>
  </tr><tr>
    <td>Fachlich: </td>
    <td><b>{{str(leistung[1][0])}}</b></td>
    <td> | Mitarbeit:</td>
    <td><b>{{leistung[1][1]}}</b></td>
    <td> | Ø Gesamt: </td>
    <td><b>{{str((float(leistung[1][0])+float(leistung[1][1]))/2) if (leistung[1][0] != '-' and leistung[1][1] != '-') else '-' }}</b></td>
</tr></table>
</td></tr></table>
<h3>Details:</h3>
<table style="border:2px solid silver;" rules="rows">
	<tr><th colspan="8">Zwischennoten etc. (Stundenfaktor = 0)</th></tr>
%for teil in teile:
%	if teil.stunde.faktor == '0':
		<tr>
            <td style="max-width: 200px; overflow: hidden;"><a href="/stunde/{{str(teil.stunde)}}" style="color:#a00;">{{str(teil.stunde.thema)}}</a></td>
            <td>{{'✓' if teil.anwesenheit == True else '✗'}}</td>
            <td>{{'✓' if teil.entschuldigt == True else '✗'}}</td>
            <td>{{'✓' if teil.hausaufgabe == True else '✗'}}</td>
            <td>{{teil.fachlich}}</td>
            <td>{{teil.mitarbeit}}</td>
            <td>{{teil.bemerkung}}</td>
            <td><a href="/teilnahme/{{str(teil)}}">Bearbeiten</a></td>
        </tr>
	%end
%end
	<tr><th colspan="8">Normale Stunden</th></tr>
    <tr><td style="width: 170px; overflow: hidden;" align="center">Datum, Faktor</td><td>A</td><td>E</td><td>Ha</td><td>Fach</td><td>Mit.</td><td width="300px">Bemerkungen</td><td></td></tr>
%for teil in teile:
%	if teil.stunde.faktor != '0':
		<tr><td style="width: 170px; overflow: hidden;"><a href="/stunde/{{str(teil.stunde)}}">{{str(teil.stunde.datum)}}, {{str(teil.stunde.faktor)}}</a></td><td>{{'✓' if teil.anwesenheit == True else '✗'}}</td><td>{{'✓' if teil.entschuldigt == True else '✗'}}</td><td>{{'✓' if teil.hausaufgabe == True else '✗'}}</td><td>{{teil.fachlich}}</td><td>{{teil.mitarbeit}}</td><td>{{teil.bemerkung}}</td><td><a href="/teilnahme/{{str(teil)}}">Bearbeiten</a></td></tr>
	%end
%end
</table>
