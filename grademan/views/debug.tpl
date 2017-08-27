%rebase base
<h1>Debuginformationen</h1>
<h2>Kurse:</h2>
<table>
<tr><td>bez</td><td>num</td><td>name</td><td>fach</td><td>oberstufe</td><td>bemerkung</td><td>deleted</td></tr>
%for kur in kurse:
	<tr>
    <td><a href = "kurs/{{kur}}">{{kur.bez()}}</a></td>
    <td>{{kur.num}}</td>
    <td>{{kur.name}}</td>
    <td>{{kur.fach}}</td>
    <td>{{kur.oberstufe}}</td>
    <td>{{kur.bemerkung}}</td>
    <td>{{kur.deleted}}</td>
    </tr>
%end
</table>
<br>
<h2>Schüler</h2>
<table>
<tr><td>bez</td><td>num</td><td>vorname</td><td>nachname</td><td>sex</td><td>bemerkung</td><td>deleted</td></tr>
%for sch in schueler:
	<tr>
    <td><a href = "kurs/{{kur}}">{{sch.bez()}}</a></td>
    <td>{{sch.num}}</td>
    <td>{{sch.vorname}}</td>
    <td>{{sch.nachname}}</td>
    <td>{{sch.sex}}</td>
    <td>{{sch.bemerkung}}</td>
    <td>{{sch.deleted}}</td>
    </tr>
%end
</table>
<br>
<h2>Stunden</h2>
<table>
<tr><td>bez</td><td>num</td><td>datum</td><td>kurs</td><td>thema</td><td>faktor</td><td>deleted</td></tr>
%for stu in stunden:
	<tr>
    <a href = "kurs/{{kur}}">{{stu.bez()}}</a><br>
    <td>{{stu.num}}</td>
    <td>{{stu.datum}}</td>
    <td>{{stu.kurs}}</td>
    <td>{{stu.thema}}</td>
    <td>{{stu.faktor}}</td>
    <td>{{stu.deleted}}</td>
    </tr>
%end
</table>
<br>
