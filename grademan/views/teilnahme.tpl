%rebase base
<h1>{{teil.schueler.bez()}}</h1>
Teilnahme <a href="/stunde/{{teil.stunde}}">{{teil.stunde.bez()}}</a><br>
<table><tr><td>
<a href="../kursschueler/{{teil.stunde.kurs.num}}/{{teil.schueler.num}}"><img src="/pictures/{{teil.schueler.pic()}}" width="230px"></a>
</td><td>
<form action="./change" method="post" accept-charset="utf-8">
    <input name="num" type="hidden" value = "{{teil.num}}">
    <table>
        <tr><td>Anwesend</td><td><input type="checkbox" name="anwesend" value="True"{{' checked' if teil.anwesenheit == True else ''}}></td></tr>
        <tr><td>Entschuldigt</td><td><input type="checkbox" name="entschuldigt" value="True"{{' checked' if teil.entschuldigt == True else ''}}></td></tr>
        <tr><td>Hausaufgabe</td><td><input type="checkbox" name="hausaufgabe" value="True"{{' checked' if teil.hausaufgabe == True else ''}}></td></tr>
    <tr><td>
        Fachlich:
        </td><td>
        <select name="fachlich" size="1">
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
        </select>
        </td><td>
        Mitarbeit:
        </td><td>
        <select name="mitarbeit" size="1">
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
        </select><br>
        </td>
    </tr></table>
    Bemerkung:<input name="bemerkung" type="text" size="45" maxlength="100" value = "{{teil.bemerkung}}"><br>
    <input type="submit" value="Speichern & nächster Schüler ">
</form>
<br>
Bemerkungen des Schülers:<br>
<pre width="45" style="text-align:left;">{{teil.schueler.bemerkung}}</pre>
</td></tr></table>
<br>
