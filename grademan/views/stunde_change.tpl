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
  <div style="text-align:left; margin: 0em 2em 2em 2em; border:1px solid black; padding:0em 1em 1em 1em; background-color: lightgrey;">
  %import markdown
  %html = markdown.markdown(stu.bemerkung.decode('utf_8'), ['asciimathml'])
  <div style="text-align:justify; font-size:small">{{!html}}</div>
  </div>
  <textarea name="bemerkung" type="text" cols="65" rows="6">{{stu.bemerkung}}</textarea><br>
    <input name="kurs" type="hidden" value="{{stu.kurs}}">
    <input type="submit" value="Datum/Thema/Bemerkung Speichern">
</form>
%if (lstu!='') and (lstu!='-'):
  Letzte Stunde: <a href="/stunde/{{lstu}}">{{lstu.thema if (lstu!='') and (lstu!='-') else ''}}</a><br>
  <!-- <textarea type="text" cols="65" rows="3" readonly="yes">{{lstu.bemerkung if (lstu!='') and (lstu!='-') else ''}}</textarea><br>-->
  <div style="text-align:left; margin: 0em 2em 2em 2em; border:1px solid black; padding:0em 1em 1em 1em; background-color: lightgrey;">
  %import markdown
  %html = markdown.markdown(lstu.bemerkung.decode('utf_8'), ['asciimathml'])
  <div style="text-align:justify; font-size:small">{{!html}}</div>
  </div>
%end
<br>
<hr>
Teilnahmenübersicht<a href="/help#teilnahmen"><img src="/static/info.png" alt="info"></a><br>
(Ø Fachlich: {{fachlichschnitt}}, Ø Mitarbeit: {{mitarbeitschnitt}})
<form action="/teilnahmen/change" method="post" accept-charset="utf-8">
<table style="border:2px solid silver;" rules="rows">
    <tr align="center"><td/><td>Vorname</td><td>Nachname</td><td>A</td><td>E</td><td>Ha</td><td>F</td><td>M</td><td width="250px">Bemerkungen</td></tr>
        %i = 0
        %for teil in teiln:
            %if (teil.stunde == stu):
                <input name="{{i}}_num" type="hidden" value = "{{teil.num}}">
    <tr>
        <td style="max-width:85px; overflow:hidden;"><a href="../kursschueler/{{teil.stunde.kurs}}/{{teil.schueler}}"><img src="/pictures/{{teil.schueler.pic()}}" width="80px" border=0></a></td>
        <td style="max-width:100px; overflow:hidden;"><a href="../kursschueler/{{teil.stunde.kurs}}/{{teil.schueler}}">{{teil.schueler.vorname}}</a><br/><div style="font-size:x-small;">{{teil.schueler.bemerkung}}</div></td>
        <td style="max-width:100px; overflow:hidden;"><a href="../kursschueler/{{teil.stunde.kurs}}/{{teil.schueler}}"><div style="font-size:small;">{{teil.schueler.nachname}}</div></a></td>
        <td>
            %if (lstu!='') and (lstu!='-'):
                %for ltei in teiln:
                    %if (ltei.schueler == teil.schueler) and (ltei.stunde == lstu) and (ltei.anwesenheit == False) and (ltei.entschuldigt == False):
                         <div style="color:red; font-size:x-small;">letzte Stunde noch nicht entschuldigt!</div>
                    %end
                %end
            %end
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
                <option{{' selected' if teil.fachlich == '-' else ''}} value="-"></option>
                %if stu.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.fachlich == str(j) else ''}} value="{{str(j)}}">{{stu.trma(j)}}</option>
                    %end
                %end
                %if stu.kurs.oberstufe==True:
                    %for j in range(0,16):
                        %if (stu.trma(j) != stu.trma(j+1)):
                            <option{{' selected' if stu.trma(teil.fachlich) == stu.trma(j) else ''}} value="{{str(j)}}">{{stu.trma(j)}}</option>
                        %end
                    %end
                %end
            </select>
        </td>
        <td>
            <select name="{{i}}_mitarbeit" size="1" tabindex="{{(i+1)*3+1001}}">
                <option{{' selected' if teil.mitarbeit == '-' else ''}} value="-"></option>
                %if stu.kurs.oberstufe==False:
                    %for j in range(1,7):
                        <option{{' selected' if teil.mitarbeit == str(j) else ''}} value="{{str(j)}}">{{stu.trma(j)}}</option>
                    %end
                %end
                %if stu.kurs.oberstufe==True:
                    %for j in range(0,16):
                        %if (stu.trma(j) != stu.trma(j+1)):
                            <option{{' selected' if stu.trma(teil.mitarbeit) == stu.trma(j) else ''}} value="{{str(j)}}">{{stu.trma(j)}}</option>
                        %end
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
