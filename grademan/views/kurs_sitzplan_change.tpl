%rebase base
<h1><a href="/kurs/sitzplan/{{kurs}}">Sitzplan {{kurs.bez()}}</a> ändern</h1>
<form action="/kurs/sitzplan/resize/{{kurs.num}}" method="post" accept-charset="utf-8">
    Breite: <input name="breite" type="text" size="2" maxlength="2" value={{kurs.sitzplanBreite}}>
    Höhe: <input name="hoehe" type="text" size="2" maxlength="2" value={{kurs.sitzplanHoehe}}>
    <input type="submit" value=" Größe neu setzen! ">
</form>
<br>
<form action="/kurs/sitzplan/changed/{{kurs.num}}" method="post" accept-charset="utf-8">
Nachnamen: <input type="checkbox" name="nachname" value="True"{{' checked' if kurs.sitzplanNachname == True else ''}}>
<table style="border:1px solid silver; background-color:white;" rules="all">
    % for h in range(kurs.sitzplanHoehe):
        <tr height="140px">
            %for b in range(kurs.sitzplanBreite):
                <td width="110px" style="max-width:110px; overflow:hidden;">
                    <select name="{{h}}_{{b}}" size="1">
                    <option></option>
                    %for sch in kurs.schueler:
                        <option value="{{sch}}"{{' selected' if kurs.sitzplan[h][b] == sch else ''}}>{{sch.bez()}}</option>
                    %end
                    </select>
                </td>
            %end
        </tr>
    %end
</table>
<input type="submit" value="Speichern">
