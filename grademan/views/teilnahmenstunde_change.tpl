%rebase base
<h1>Alle Teilnahmen der Stunde bearbeiten</h1>
<a href="/kurs/{{stu.kurs}}">{{stu.kurs.bez()}}</a>, <a href="/stunde/{{stu}}">{{stu.datum.day}}.{{stu.datum.month}}.{{stu.datum.year}}</a><br>
Thema: {{stu.thema}}<br>
Faktor (Schulstunden): {{stu.faktor}}<br>
Bemerkungen:<br>
<div style="text-align:left; margin: 0em 2em 2em 2em; border:1px solid black; padding:0em 1em 1em 1em; background-color: lightgrey;">
  %import markdown
  %html = markdown.markdown(stu.bemerkung.decode('utf_8'), ['asciimathml'])
{{!html}}
</div>
<br>
Teilnahmen<a href="/help#teilnahmen"><img src="/static/info.png" alt="info"></a><br>
<form action="/teilnahmen/change" method="post" accept-charset="utf-8">
<table style="border:2px solid silver;" rules="rows">
        %i = 0
        %for teil in teiln:
            %if (teil.stunde == stu):
    <input name="{{i}}_num" type="hidden" value = "{{teil.num}}">
    <tr>
        <td><img src="/pictures/{{teil.schueler.pic()}}" width="100px" /></td>
        <td style="max-width:185px; overflow:hidden;"><a href="../kursschueler/{{teil.stunde.kurs}}/{{teil.schueler}}">{{teil.schueler.bez()}}</a></td>
        <td>
            A<input type="checkbox" name="{{i}}_anwesend" value="True"{{' checked' if teil.anwesenheit == True else ''}} tabindex="{{(i+1)*3}}"><br>
            E<input type="checkbox" name="{{i}}_entschuldigt" value="True"{{' checked' if teil.entschuldigt == True else ''}} tabindex="{{(i+1)*3+1}}"><br>
            Ha<input type="checkbox" name="{{i}}_hausaufgabe" value="True"{{' checked' if teil.hausaufgabe == True else ''}} tabindex="{{(i+1)*3+2}}">
        </td>
        <td>
            F<select name="{{i}}_fachlich" size="1" tabindex="{{(i+1)*3+1000}}">
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
            </select><br>
            M<select name="{{i}}_mitarbeit" size="1" tabindex="{{(i+1)*3+1001}}">
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
            Bemerkungen:<br>
            <input name="{{i}}_bemerkung" type="text" size="18" maxlength="100" value = "{{teil.bemerkung}}" tabindex="{{(i+1)*3+1002}}">
        </td>
    </tr>
    %i += 1
            %end
        %end
</table>
<input type="submit" value="Speichern" tabindex="{{(i+1)*3+1003}}">
</form>
