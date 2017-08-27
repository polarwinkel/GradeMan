%for kurs in kurse:
    %if kurs.deleted==False:
        "{{kurs.num}}", "{{kurs.name}}", "{{kurs.fach}}", "{{kurs.bemerkung}}"\\
    %end
%for sch in kurs.schueler:
, "{{str(sch)}}"\\
%end

%end
