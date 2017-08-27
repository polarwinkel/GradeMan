%rebase base
<h1>Schüler hinzufügen<a href="/help#schueleradd"><img src="/static/info.png" alt="info"></a></h1>
<br>
<form action="./change" method="post" accept-charset="utf-8" enctype="multipart/form-data">
  <input name="num" type="hidden" value={{schueler.num}}>
  Vorname <input name="vorname" type="text" size="20" maxlength="40"><br>
  Nachname <input name="nachname" type="text" size="20" maxlength="40"><br>
  Geschlecht <select name="sex"><option>m</option><option>w</option></select><br>
  Bemerkungen:<br>
  <textarea name="bemerkung" type="text" cols="45" rows="4"></textarea><br>
  Schülerbild:<br>
  <input type="file" name="bild" /><br />
  <input type="submit" value=" Speichern ">
</form>
