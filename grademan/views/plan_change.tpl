%rebase base
<h1>Stundenplan ändern</h1>
<form action="/planchange" method="post" accept-charset="utf-8">
<table style="border:2px solid silver;" rules="rows">
    <tr>
        <td width="150px">Zeit</td>
        <td width="150px">Montag</td>
        <td width="150px">Dienstag</td>
        <td width="150px">Mittwoch</td>
        <td width="150px">Donnerstag</td>
        <td width="150px">Freitag</td>
    </tr>
    % for i in range(len(stundenplan['zeit'])):
    <tr>
        <td>
            <input name="{{i}}zeit" type="text" size="6" maxlength="30" value = "{{stundenplan['zeit'][i]}}">
        </td>
        <td style="max-width:150px; overflow:hidden;">
            <select name="{{i}}mo" size="1">
                <option{{'' if kurs_in_db(stundenplan['mo'][i]) else ' selected'}}>-</option>
                %for j in range(len(kurse)):
                    %if kurse[j].deleted==False:
                        <option value="{{kurse[j]}}"{{' selected' if stundenplan['mo'][i] == str(kurse[j]) else ''}}>{{kurse[j].bez()}}</option>
                    %end
                %end
            </select>
        </td>
        <td style="max-width:150px; overflow:hidden;">
            <select name="{{i}}di" size="1">
                <option{{'' if kurs_in_db(stundenplan['di'][i]) else ' selected'}}>-</option>
                %for j in range(len(kurse)):
                    %if kurse[j].deleted==False:
                        <option value="{{kurse[j]}}"{{' selected' if stundenplan['di'][i] == str(kurse[j]) else ''}}>{{kurse[j].bez()}}</option>
                    %end
                %end
            </select>
        </td>
        <td style="max-width:150px; overflow:hidden;">
            <select name="{{i}}mi" size="1">
                <option{{'' if kurs_in_db(stundenplan['mi'][i]) else ' selected'}}>-</option>
                %for j in range(len(kurse)):
                    %if kurse[j].deleted==False:
                        <option value="{{kurse[j]}}"{{' selected' if stundenplan['mi'][i] == str(kurse[j]) else ''}}>{{kurse[j].bez()}}</option>
                    %end
                %end
            </select>
        </td>
        <td style="max-width:150px; overflow:hidden;">
            <select name="{{i}}do" size="1">
                <option{{'' if kurs_in_db(stundenplan['do'][i]) else ' selected'}}>-</option>
                %for j in range(len(kurse)):
                    %if kurse[j].deleted==False:
                        <option value="{{kurse[j]}}"{{' selected' if stundenplan['do'][i] == str(kurse[j]) else ''}}>{{kurse[j].bez()}}</option>
                    %end
                %end
            </select>
        </td>
        <td style="max-width:150px; overflow:hidden;">
            <select name="{{i}}fr" size="1">
                <option{{'' if kurs_in_db(stundenplan['fr'][i]) else ' selected'}}>-</option>
                %for j in range(len(kurse)):
                    %if kurse[j].deleted==False:
                        <option value="{{kurse[j]}}"{{' selected' if stundenplan['fr'][i] == str(kurse[j]) else ''}}>{{kurse[j].bez()}}</option>
                    %end
                %end
            </select>
        </td>
    </tr>
    %end
</table>
<input type="submit" value="Speichern">
</form>
