function [] = checkUncheck(hObject)
% [] = checkUncheck(hObject)
% does the check/uncheck action for drop down menus

val = get(hObject, 'Checked');

switch val
    case 'on'
        val = 'off';
    case 'off'
        val = 'on';
    otherwise
        error('Invalid Checked Value');
end

set(hObject, 'Checked', val);

end

