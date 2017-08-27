%for sch in schueler:
    %if sch.deleted==False:
        "{{sch.num}}", "{{sch.vorname}}", "{{sch.nachname}}", "{{sch.sex}}", "{{sch.bemerkung}}"
    %end
%end
