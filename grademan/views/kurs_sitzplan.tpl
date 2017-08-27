%rebase base
<h1>Sitzplan <a href="/kurs/{{kurs}}">{{kurs.bez()}}</a></h1>
<table style="border:1px solid silver; background-color:white;" rules="all">
    % for h in range(kurs.sitzplanHoehe):
        <tr height="140px">
            %for b in range(kurs.sitzplanBreite):
                <td width="110px" style="max-width:100px; overflow:hidden;">
                    %if kurs.sitzplan[h][b] != '':
                        <a href = "/kursschueler/{{kurs}}/{{kurs.sitzplan[h][b]}}">
                        <img src="/pictures/{{kurs.sitzplan[h][b].pic()}}" width="98px" border=0>
                        </a>
                        <p style="margin-top:-1.5em; margin-bottom:0; color: white; text-shadow:black 3px 2px 1px;">
                        {{kurs.sitzplan[h][b].vorname if kurs.sitzplanNachname == False else kurs.sitzplan[h][b].nachname}}
                        </p>
                    %end
                </td>
            %end
        </tr>
    %end
</table>
<a href="/kurs/sitzplan/change/{{kurs.num}}">Sitzplan ändern</a> | 
<a href="/kurs/sitzplan/noname/{{kurs.num}}">Namen ausblenden</a>
<br>
