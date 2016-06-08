function [ result ] = PlaySave()

%displays a dialog box and returns 1 when user chooses 'Play and Plot', 2
%for 'Save' and 3 for 'Exit'

choice = questdlg('What do you want to do?','Musical Synthesis',...
	'Play and Plot', ...
	'Save','Exit','Play and Plot');
% Handle response
switch choice
    case 'Play and Plot'
        result = 1;
    case 'Save'
        result = 2;
       
    otherwise
        result = 3;
end
end

