%rebase base
<h1>Stundenliste</h1>
Aktionen:<br>
<a href = "./new">neue Stunde</a><br>
<br>
Liste aller existierender Stunden:<br>
%for stu in stunden:
    %if stu.deleted==False:
        %if stu.faktor == '0':
            <a href = "./{{stu}}" style="color:#a00;">{{stu.datum}} {{stu.thema}} - {{stu.kurs.bez(stu.kurs)}}</a><br>
        %else:
            <a href = "./{{stu}}">{{stu.datum}} {{stu.thema}} - {{stu.kurs.bez(stu.kurs)}}</a><br>
        %end;
    %end
%end
