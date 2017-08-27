%rebase base
<h1>Teilnahmen-Sitzplan <a href="/kurs/{{stu.kurs}}">{{stu.kurs.bez()}}</a>, <a href="/stunde/{{stu}}">{{stu.datum}}</a></h1>
<p>Checkboxen: Anwesenheit | Entschudigt | Hausaufgaben<br>
Notenauswahlen: Fachlich | Mitarbeit</p>
<form action="/teilnahmen/change" method="post" accept-charset="utf-8">
<table style="border:1px solid silver; background-color:white;" rules="all">
%i = 0 # Zaehlvariable für die Teilnahmen ausserhalb der Tabellenschleife definieren
    % for h in range(stu.kurs.sitzplanHoehe):
        <tr height="140px">
            %for b in range(stu.kurs.sitzplanBreite):
                <td width="120px" style="max-width:120px; overflow:hidden; text-align: center;">
                    %if stu.kurs.sitzplan[h][b] != '':
                        <a href = "/kursschueler/{{stu.kurs}}/{{stu.kurs.sitzplan[h][b]}}">
                        <img src="/pictures/{{stu.kurs.sitzplan[h][b].pic()}}" width="98px" border=0>
                        </a>
%for teil in teiln:
    %if (teil.schueler == stu.kurs.sitzplan[h][b]):
        %print 'obenInnen %s' % i
        <p style="margin-top:-1.5em; margin-bottom:0; color: white; text-shadow:black 3px 2px 1px;">
        {{stu.kurs.sitzplan[h][b].vorname if stu.kurs.sitzplanNachname == False else stu.kurs.sitzplan[h][b].nachname}}<br>
        <input name="{{i}}_num" type="hidden" value = "{{teil.num}}">
        <input type="checkbox" name="{{i}}_anwesend" value="True"{{' checked' if teil.anwesenheit == True else ''}}>
        <input type="checkbox" name="{{i}}_entschuldigt" value="True"{{' checked' if teil.entschuldigt == True else ''}}>
        <input type="checkbox" name="{{i}}_hausaufgabe" value="True"{{' checked' if teil.hausaufgabe == True else ''}}>
        <select name="{{i}}_fachlich" size="1">
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
        <select name="{{i}}_mitarbeit" size="1">
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
        <input name="{{i}}_bemerkung" type="hidden" value = "{{teil.bemerkung}}">
        </p>
        %i += 1
    %end
%end
                    %end
                </td>
            %end
        </tr>
    %end
</table>
<input type="submit" value="Speichern">
</form>
