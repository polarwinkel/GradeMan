%rebase base
<h1>Schülerübersicht der <a href="/kurs/{{kur.num}}">{{kur.bez()}}</a></h1>
<table style="width:960px; margin:0;"><tr><td>
%for sch in kur.schueler:
    %if sch.deleted==False:
        <table style="float:left; width:195px; height:440px;"><tr><td>
        <a href = "../kursschueler/{{kur}}/{{sch}}"><img src="/pictures/{{sch.pic()}}" width="230px" border=0></a>
        </td></tr><tr><td>
        <a href = "../kursschueler/{{kur}}/{{sch}}">{{sch.bez()}}</a>
        </td></tr></table>
    %end
%end
</table>
<p><a href="/kursuebersicht/noname/{{kur.num}}">Namen ausblenden</a></p>
<br>
