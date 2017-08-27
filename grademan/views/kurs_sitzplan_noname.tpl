%rebase base
<h1>Sitzplan <a href="/kurs/{{kurs}}">{{kurs.bez()}}</a></h1>
<table style="border:1px solid silver; background-color:white;" rules="all">
    % for h in range(kurs.sitzplanHoehe):
        <tr height="140px">
            %for b in range(kurs.sitzplanBreite):
                <td width="110px" style="max-width:100px; overflow:hidden;">
                    %if kurs.sitzplan[h][b] != '':
                        <a href = "/kursschueler/{{kurs}}/{{kurs.sitzplan[h][b]}}">
                        <img src="/pictures/{{kurs.sitzplan[h][b].pic()}}" title="{{kurs.sitzplan[h][b].bez()}}" width="98px" border=0>
                        </a>
                    %end
                </td>
            %end
        </tr>
    %end
</table>
Mit der Maus über ein Bild gehen um den Namen zu erfahren!<br />
<a href="/kurs/sitzplan/{{kurs.num}}">Namen einblenden</a>
<br>
