%rebase base
<h1>GradeMan Startseite</h1>
<form action="/noteschange" method="post" accept-charset="utf-8">
    <textarea name="note" type="text" cols="65" rows="6" style="float:left; margin-left:12px; margin-bottom:15px;">{{notes}}</textarea>
    <br>Notizen/Termine<br>
    <input type="submit" value=" Speichern ">
</form>
<br>
<table style="border:2px solid silver;" rules="all">
    <tr>
        <td>Zeit</td>
        <td style="max-width:150px; overflow:hidden;">Montag</td>
        <td style="max-width:150px; overflow:hidden;">Dienstag</td>
        <td style="max-width:150px; overflow:hidden;">Mittwoch</td>
        <td style="max-width:150px; overflow:hidden;">Donnerstag</td>
        <td style="max-width:150px; overflow:hidden;">Freitag</td>
    </tr>
    % for i in range(len(stundenplan['zeit'])):
    <tr>
        <td>{{stundenplan['zeit'][i]}}</td>
        <td style="max-width:160px; overflow:hidden;"><a href="{{'/kurs/%s' % stundenplan['mo'][i] if kurs_in_db(stundenplan['mo'][i]) else '/'}}">{{kurs_in_db(stundenplan['mo'][i], True).bez() if kurs_in_db(stundenplan['mo'][i]) else '-'}}</a></td>
        <td style="max-width:160px; overflow:hidden;"><a href="{{'/kurs/%s' % stundenplan['di'][i] if kurs_in_db(stundenplan['di'][i]) else '/'}}">{{kurs_in_db(stundenplan['di'][i], True).bez() if kurs_in_db(stundenplan['di'][i]) else '-'}}</a></td>
        <td style="max-width:160px; overflow:hidden;"><a href="{{'/kurs/%s' % stundenplan['mi'][i] if kurs_in_db(stundenplan['mi'][i]) else '/'}}">{{kurs_in_db(stundenplan['mi'][i], True).bez() if kurs_in_db(stundenplan['mi'][i]) else '-'}}</a></td>
        <td style="max-width:160px; overflow:hidden;"><a href="{{'/kurs/%s' % stundenplan['do'][i] if kurs_in_db(stundenplan['do'][i]) else '/'}}">{{kurs_in_db(stundenplan['do'][i], True).bez() if kurs_in_db(stundenplan['do'][i]) else '-'}}</a></td>
        <td style="max-width:160px; overflow:hidden;"><a href="{{'/kurs/%s' % stundenplan['fr'][i] if kurs_in_db(stundenplan['fr'][i]) else '/'}}">{{kurs_in_db(stundenplan['fr'][i], True).bez() if kurs_in_db(stundenplan['fr'][i]) else '-'}}</a></td>
    </tr>
    %end
</table>
<a href="/chplan">Stundenplan ändern</a><br>
