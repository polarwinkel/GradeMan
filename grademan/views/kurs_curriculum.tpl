%rebase base
<h1>Curriculum <a href="/kurs/{{kur.num}}">{{kur.bez()}}</a></h1>
%for i in range(len(stunden)):
    %if (stunden[i].kurs == kur) and (stunden[i].deleted==False):
	<div style="text-align:left; margin: 0em 2em 2em 2em; border:1px solid black; padding:0em 1em 1em 1em; background-color: lightgrey;">
        %if stunden[i].faktor == '0':
            <h3 style="color:#a00;">
        %else:
            <h3>
        %end;
        {{stunden[i].datum}} [{{stunden[i].faktor}}]:
        <a href="../stunde/{{stunden[i]}}">{{stunden[i].thema}}</a></h3>
        <!-- <pre width="65" style="text-align:left;">{{stunden[i].bemerkung}}</pre> -->
	%import markdown
	%html = markdown.markdown(stunden[i].bemerkung.decode('utf_8'), ['asciimathml'])
	<div style="text-align:justify; font-size:small">{{!html}}</div>
	</div>
    %end
%end
