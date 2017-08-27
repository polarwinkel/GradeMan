num, Kurs, Stunde, Schüler, anwesend, entschuldigt, Hausaufgabe, Fachlich, Mitarbeit, Bemerkung
%for teil in teilnahmen:
"{{str(teil.num)}}", "{{teil.stunde.kurs.bez()}}", "{{teil.stunde.bez()}}", "{{teil.schueler.bez()}}", "{{str(teil.anwesenheit)}}", "{{str(teil.entschuldigt)}}", "{{str(teil.hausaufgabe)}}", "{{str(teil.fachlich)}}", "{{str(teil.mitarbeit)}}", "{{str(teil.bemerkung)}}"
%end
