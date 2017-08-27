%rebase base
<h1>Stunde erstellen</h1>
<form action="/stunde/change" method="post" accept-charset="utf-8">
    <input name="num" type="hidden" value = "{{str(stu.num)}}">
    Tag: <input name="tag" type="text" size="2" maxlength="2" value = "{{stu.datum.day}}"> Monat: <input name="monat" type="text" size="2" maxlength="2" value = "{{stu.datum.month}}"> Jahr: <input name="jahr" type="text" size="4" maxlength="4" value = "{{stu.datum.year}}"><br>
    Faktor<a href="/help#stundefaktor"><img src="/static/info.png" alt="info"></a>: <select name="faktor" size="1">
        %for i in range(6):
            <option{{' selected' if str(stu.faktor) == str(i) else ''}}>{{str(i)}}</option>
        %end
    </select>
        %if (lstu==''):
            <select name="kurs" size="1">
                <option>Kurs wählen:</option>
                %for kur in kurse:
                    <option value={{kur}}>{{kur.bez()}}</option>
                %end
            </select>
        %end
    <input name="thema" type="text" size="40" maxlength="100" value = "{{stu.thema}}"><br>
    Stundenverlauf/Bemerkungen:<br>
    <textarea name="bemerkung" type="text" cols="65" rows="6">{{stu.bemerkung}}</textarea><br>
    <input type="submit" value=" Speichern ">
%if lstu!='':
    <input type="hidden" name="kurs" value="{{kurs}}">
    %if lstu != '-':
        <br>
        Letzte Stunde <a href="/kurs/{{lstu.kurs}}">{{lstu.kurs.bez()}}</a>: <a href="/stunde/{{lstu}}">{{lstu.thema if lstu!='' else ''}}</a> (zum <a href="/kurscurriculum/{{stu.kurs.num}}">Curriculum</a>)<br>
        <textarea type="text" cols="65" rows="6" readonly="yes">{{lstu.bemerkung if lstu!='' else ''}}</textarea><br>
    %end
%end
</form>
