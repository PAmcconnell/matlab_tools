function log = isNumberOrNan(string)
% FORMAT log = isNumberOrNan(string)
% Determines if input is a numberString (or a nanString) or not.

if (all(ismember(string, '0123456789.-')) && ~isDate(string)) || isNanString(string)
    log = true;
else
    log = false;
end
end

%% Internal function: isDate
function log = isDate(string)
if length(strfind(string, '-')) > 1
    log = true;
else
    log = false;
end
end

%% Internal function: convertStringToNumber
function log = isNanString(string)
if ~isempty(str2num(string))
    log = isnan(str2num(string));
else
    log = false;
end
end
