%rebase base
<h1>Stunde bearbeiten</h1>
<div class="pagemenu">
Teilnahmen bearbeiten: <a href="/teilnahme/{{str(teil)}}">Assistent</a> | 
<a href="/teilnahmen/{{str(stu)}}">Alle</a> | 
<a href="/teilnahmen/sitzplan/{{str(stu)}}">mit Sitzplan</a>
</div>
<div class="pagemenu">
Kursoptionen: <a href="/kurs/sitzplan/{{stu.kurs.num}}">Sitzplan</a> | 
<a href="/kurscurriculum/{{stu.kurs.num}}">Curriculum</a> | 
<a href="/lernnamen/{{stu.kurs.num}}">Zufallsschüler</a>
Neue Stunde: <a href="/stunde/new/{{stu.kurs.num}}">Heute</a> | 
<a href="/stunde/new/{{stu.kurs.num}}/1">Morgen</a>
</div>
<a href="/kurs/{{stu.kurs}}">{{stu.kurs.bez()}}</a>, {{stu.datum.day}}.{{stu.datum.month}}.{{stu.datum.year}}
<form action="./change" method="post" accept-charset="utf-8">
  <input name="num" type="hidden" value = "{{str(stu.num)}}">
  Datum:<input name="tag" type="text" size="2" maxlength="2" value = "{{stu.datum.day}}">
  <input name="monat" type="text" size="2" maxlength="2" value = "{{stu.datum.month}}">
  <input name="jahr" type="text" size="4" maxlength="4" value = "{{stu.datum.year}}"><br>
  Thema: <input name="thema" type="text" size="40" maxlength="100" value = "{{stu.thema}}"><br>
  Faktor (Schulstunden): <select name="faktor" size="1">
      %for i in range(6):
        <option{{' selected' if str(stu.faktor) == str(i) else ''}}>{{str(i)}}</option>
     %end
  </select><br>
  Stundenverlauf/Bemerkungen:<br>
  <textarea name="bemerkung" type="text" cols="65" rows="6">{{stu.bemerkung}}</textarea><br>
    <input name="kurs" type="hidden" value="{{stu.kurs}}">
    <input type="submit" value="Datum/Thema/Bemerkung Speichern">
</form>
Letzte Stunde: <a href="/stunde/{{lstu}}">{{lstu.thema if (lstu!='') and (lstu!='-') else ''}}</a><br>
<textarea type="text" cols="65" rows="3" readonly="yes">{{lstu.bemerkung if (lstu!='') and (lstu!='-') else ''}}</textarea><br>
<br>
<hr>
Teilnahmenübersicht<a href="/help#teilnahmen"><img src="/static/info.png" alt="info"></a><br>
(Ø Fachlich: {{fachlichschnitt}}, Ø Mitarbeit: {{mitarbeitschnitt}})
<form action="/teilnahmen/change" method="post" accept-charset="utf-8">
<table style="border:2px solid silver;" rules="rows">
    <tr align="center"><td>Vorname</td><td>Nachname</td><td>A</td><td>E</td><td>Ha</td><td>F</td><td>M</td><td width="300px">Bemerkungen</td></tr>
        %i = 0
        %for teil in teiln:
            %if (teil.stunde == stu):
                <input name="{{i}}_num" type="hidden" value = "{{teil.num}}">
    <tr>
        <td style="max-width:100px; overflow:hidden;"><a href="../kursschueler/{{teil.stunde.kurs}}/{{teil.schueler}}">{{teil.schueler.vorname}}</a></td>
        <td style="max-width:100px; overflow:hidden;"><a href="../kursschueler/{{teil.stunde.kurs}}/{{teil.schueler}}">{{teil.schueler.nachname}}</a></td>
        <td>
            <input type="checkbox" name="{{i}}_anwesend" value="True"{{' checked' if teil.anwesenheit == True else ''}} tabindex="{{(i+1)*3}}">
        </td>
        <td>
            <input type="checkbox" name="{{i}}_entschuldigt" value="True"{{' checked' if teil.entschuldigt == True else ''}} tabindex="{{(i+1)*3+1}}">
        </td>
        <td>
            <input type="checkbox" name="{{i}}_hausaufgabe" value="True"{{' checked' if teil.hausaufgabe == True else ''}} tabindex="{{(i+1)*3+2}}">
        </td>
        <td>
            <select name="{{i}}_fachlich" size="1" tabindex="{{(i+1)*3+1000}}">
                <option{{' selected' if teil.fachlich == '-' else ''}}>-</option>
                %if stu.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.fachlich == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
                %if stu.kurs.oberstufe==True:
                    %for j in range(0,16):
                        <option{{' selected' if teil.fachlich == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
            </select>
        </td>
        <td>
            <select name="{{i}}_mitarbeit" size="1" tabindex="{{(i+1)*3+1001}}">
                <option{{' selected' if teil.mitarbeit == '-' else ''}}>-</option>
                %if stu.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
                %if stu.kurs.oberstufe==True:
                    %for j in range(0,16):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}}>{{str(j)}}</option>
                    %end
                %end
            </select>
        </td>
        <td>
            <input name="{{i}}_bemerkung" type="text" size="25" maxlength="100" value = "{{teil.bemerkung}}" tabindex="{{(i+1)*3+1002}}">
        </td>
    </tr>
            %i += 1
            %end
        %end
</table>
<input type="submit" value="Teilnahmen Speichern" tabindex="{{(i+1)*3+1003}}">
</form>
