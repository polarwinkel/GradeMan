%rebase base
<h1>Teilnahmeliste</h1>
<br>
Liste aller existierender Teilnahmen für alle Kurse:<br>
%for teil in teile:
    <a href = "./{{teil}}">{{teil}}</a><br>
%end
