%rebase base
<h1>Schüler Details</h1>
<h2 style="display:inline;"><a href="/schueler/{{schueler}}">{{schueler.bez()}}</a></h2>
, <a href="/kurs/{{kurs.num}}">{{kurs.bez()}}</a> (Nächster: <a href="/kursschueler/{{kurs.num}}/{{nsch if nsch!= '' else ''}}">{{nsch.bez() if nsch!= '' else ''}}</a>)<br><br>
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
<h3>Errechnete Gesamtnote</h3>
<table><tr>
    <td><h4>1. HJ: </h4></td>
    <td>{{str(schriftl[0])}} <span style="font-size: x-small;">({{str(kurs.gewS()*100)}}%)</span> + </td>
    <td>{{str((float(leistung[0][0])+float(leistung[0][1]))/2) if (leistung[0][0] != '-' and leistung[0][1] != '-') else '-' }} <span style="font-size: x-small;">({{str((1.0-kurs.gewS())*100)}}%)</span></td>
    <td>= <b>{{str( ( ( ( float(leistung[0][0]) + float(leistung[0][1]) ) / 2 ) * float(1.0-kurs.gewS()) ) + ( float(schriftl[0]) * float(kurs.gewS()) ) ) if (leistung[0][0] != '-' and leistung[0][1] != '-' and schriftl[0] != '-') else '-' }}</b></td>
</tr><tr>
    <td><h4>2. HJ: </h4></td>
    <td>{{str(schriftl[1])}} <span style="font-size: x-small;">({{str(kurs.gewS()*100)}}%)</span> + </td>
    <td>{{str((float(leistung[1][0])+float(leistung[1][1]))/2) if (leistung[1][0] != '-' and leistung[1][1] != '-') else '-' }} <span style="font-size: x-small;">({{str((1.0-kurs.gewS())*100)}}%)</span></td>
    <td>= <b>{{str( ( ( ( float(leistung[1][0]) + float(leistung[1][1]) ) / 2 ) * float(1.0-kurs.gewS()) ) + ( float(schriftl[1]) * float(kurs.gewS()) ) ) if (leistung[1][0] != '-' and leistung[1][1] != '-' and schriftl[1] != '-') else '-' }}</b></td>
</tr></table>
</td></tr></table>
<p style="text-align: left;">Beachte, dass die errechnete Gesamtnote nur einen Hinweis zur Notenfindung geben kann. Die tatsächliche Note muss eine pädagogische Note sein!</p>
<p style="font-size: x-small; text-align: left;">Wenn in einer Stunde keine fachliche Note eingetragen ist (also '-'), dann wird die Mitarbeitsnote ebenfalls ignoriert. So können Noten-Notizen rein informativ angelegt werden. Z.B. zum Festhalten der tatsächlich gegebenen Halbjahresnote</p>
<h3>Details:</h3>
<table style="border:2px solid silver;" rules="rows">
	<tr><th colspan="8">Zwischennoten etc. (Stundenfaktor = 0)</th></tr>
%for teil in teile:
%	if teil.stunde.faktor == '0':
		<tr><form method="post" action="/kursschueler/change" accept-charset="utf-8">
            <input type="hidden" name="tnum" value="{{str(teil.num)}}">
            <input type="hidden" name="schueler" value="{{str(schueler)}}">
            <td style="max-width: 200px; overflow: hidden;"><a href="/stunde/{{str(teil.stunde)}}" style="color:#a00;">{{str(teil.stunde.thema)}}</a></td>
            <td><input type="checkbox" name="anwesend" value="True"{{' checked' if teil.anwesenheit == True else ''}}></td>
            <td><input type="checkbox" name="entschuldigt" value="True"{{' checked' if teil.entschuldigt == True else ''}}></td>
            <td><input type="checkbox" name="hausaufgabe" value="True"{{' checked' if teil.hausaufgabe == True else ''}}></td>
            <td><select name="fachlich" size=1>
                <option{{' selected' if teil.fachlich == '-' else ''}}>-</option>
                %if teil.stunde.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.fachlich == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
                %if teil.stunde.kurs.oberstufe==True:
                    %for j in range(0,16):
                        <option{{' selected' if teil.fachlich == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
            </select></td>
            <td><select name="mitarbeit" size=1>
                <option{{' selected' if teil.mitarbeit == '-' else ''}}>-</option>
                %if teil.stunde.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
                %if teil.stunde.kurs.oberstufe==True:
                    %for j in range(0,16):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
            </select></td>
            <td><input name="bemerkung" type="text" size="20" maxlength="100" value = "{{teil.bemerkung}}"></td>
            <td><input type="submit" value="Speichern"></td>
        </form></tr>
	%end
%end
	<tr><th colspan="8">Normale Stunden</th></tr>
    <tr><td style="width: 170px; overflow: hidden;" align="center">Datum, Faktor</td><td>A</td><td>E</td><td>Ha</td><td>Fach</td><td>Mit.</td><td width="300px">Bemerkungen</td><td></td></tr>
%for teil in teile:
%	if teil.stunde.faktor != '0':
		<tr><form method="post" action="/kursschueler/change" accept-charset="utf-8">
            <input type="hidden" name="tnum" value="{{str(teil.num)}}">
            <input type="hidden" name="schueler" value="{{str(schueler)}}">
            <td style="max-width: 200px; overflow: hidden;"><a href="/stunde/{{str(teil.stunde)}}"><div style="font-size: x-small;">{{str(teil.stunde.thema)}} {{str(teil.stunde.datum)}}, {{str(teil.stunde.faktor)}}</div></a></td>
            <td><input type="checkbox" name="anwesend" value="True"{{' checked' if teil.anwesenheit == True else ''}}></td>
            <td><input type="checkbox" name="entschuldigt" value="True"{{' checked' if teil.entschuldigt == True else ''}}></td>
            <td><input type="checkbox" name="hausaufgabe" value="True"{{' checked' if teil.hausaufgabe == True else ''}}></td>
            <td><select name="fachlich" size=1>
                <option{{' selected' if teil.fachlich == '-' else ''}}>-</option>
                %if teil.stunde.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.fachlich == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
                %if teil.stunde.kurs.oberstufe==True:
                    %for j in range(0,16):
                        <option{{' selected' if teil.fachlich == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
            </select></td>
            <td><select name="mitarbeit" size=1>
                <option{{' selected' if teil.mitarbeit == '-' else ''}}>-</option>
                %if teil.stunde.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
                %if teil.stunde.kurs.oberstufe==True:
                    %for j in range(0,16):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
            </select></td>
            <td><input name="bemerkung" type="text" size="20" maxlength="100" value = "{{teil.bemerkung}}"></td>
            <td><input type="submit" value="Speichern"></td>
        </form></tr>
	%end
%end
</table>
