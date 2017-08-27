%rebase base
<h1>Schülerübersicht der <a href="/kurs/{{kur.num}}">{{kur.bez()}}</a></h1>
<table style="width:960px; margin:0;"><tr><td>
%for sch in kur.schueler:
    %if sch.deleted==False:
        <table style="float:left; width:195px; height:440px;"><tr><td>
        <a href = "../kursschueler/{{kur}}/{{sch}}"><img src="/pictures/{{sch.pic()}}" title="{{sch.bez()}}" width="230px" border=0></a>
        </td></tr></table>
    %end
%end
</table>
<p>
Mit der Maus über ein Bild fahren um den Namen zu erfahren!<br />
<a href="/kursuebersicht/{{kur.num}}">Namen einblenden</a>
</p>
<br>
