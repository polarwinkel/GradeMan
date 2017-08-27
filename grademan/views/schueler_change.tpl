%rebase base
<h1>Schüler bearbeiten</h1>
<h2>{{schueler.bez()}}, {{schueler.sex}}</h2>
<table><tr><td>
<img src="/pictures/{{schueler.pic()}}" width="200px">
</td><td>
<form action="./change" method="post" accept-charset="utf-8" enctype="multipart/form-data">
  <input name="num" type="hidden" value="{{schueler.num}}">
  <input name="vorname" type="text" size="10" maxlength="40" value = "{{schueler.vorname}}">
  <input name="nachname" type="text" size="10" maxlength="40" value = "{{schueler.nachname}}">
  <select name="sex" size="1">
    <option{{' selected' if schueler.sex == 'm' else ''}}>m</option>
    <option{{' selected' if schueler.sex == 'w' else ''}}>w</option>
  </select>
  Bemerkungen:<br>
  <textarea name="bemerkung" type="text" cols="45" rows="4">{{schueler.bemerkung}}</textarea><br>
  neues Schülerbild (optional):<br>
  <input type="file" name="bild" /><br />
  <input type="submit" value=" Speichern "><br>
</form>
Kurse des Schülers:<br>
    %for kur in kurse:
        %if kur.deleted==False:
            <a href="../kursschueler/{{kur}}/{{schueler}}">{{kur.bez()}}</a><br>
        %end
    %end
</td></tr></table>
