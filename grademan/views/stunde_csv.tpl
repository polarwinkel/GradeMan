%for stu in stunden:
    %if stu.deleted==False:
        "{{str(stu.num)}}", "{{str(stu.datum)}}", "{{str(stu.kurs)}}", "{{str(stu.faktor)}}", "{{str(stu.bemerkung)}}"
    %end
%end
