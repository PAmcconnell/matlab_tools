function newStructure = stringReplace(oldStructure, oldString, newString)
% FORMAT newStructure = stringReplace(oldStructure, oldString, newString)
% Does a recursive replacement of strings in a data structure.
% It should work with char arrays, cell arrays, and structures.
% In SPM can be used to modify SPM.mat files and job files.
%
%
% Inputs:
% oldStructure:     the original data structure
% oldString:        string to be replaced
% newString:        replacement string
%
% Outputs:
% newStructure:     the data structure with strings replaced
%
%
% 080723 Created by Dennis Thompson

dataType = class(oldStructure);

switch dataType        
    case 'cell' % if type is cell we need to do a recursion
        newStructure = expandCell(oldStructure, oldString, newString);  
    case 'struct' % if type is struct we need to do a recursion
        newStructure = expandStructure(oldStructure, oldString, newString);
    case 'char' % if data type is char we can do the replacement
        newStructure = replaceString(oldStructure, oldString, newString);
    otherwise  % if data type is "none of the above" we don't do anything
        newStructure = oldStructure;
end
end

function newStructure = replaceString(oldStructure, oldString, newString)
% FORMAT newStructure = replaceString(oldStructure, oldString, newString)
[row, col] = size(oldStructure);
% Test empty array.
if ~and(row, col)
    newStructure = oldStructure;
else
    for iRow = 1:row % I am assuming that the string is stored in a row vector :-)
        newStructure(iRow, :) = regexprep(oldStructure(iRow, :), oldString, newString);
    end
end
end

function newStructure = expandCell(oldStructure, oldString, newString)
% FORMAT newStructure = expandCell(oldStructure, oldString, newString)
% Recursively calls for each cell in cell array oldStructure.
[row, col] = size(oldStructure);
% Check for zero arrays.
if ~and(row, col)
    newStructure = oldStructure;
else
    for iRow = 1:row,
        for jCol = 1:col % Recursive call
            newStructure{iRow, jCol} = stringReplace(oldStructure{iRow, jCol}, oldString, newString);
        end
    end
end
end

function newStructure = expandStructure(oldStructure, oldString, newString)
% FORMAT newStructure = expandStructure(oldStructure, oldString, newString)
% Recursively calls each field in structure oldStructure.
[row, col] = size(oldStructure);
% Check for zero arrays.
if ~and(row, col)
    newStructure = oldStructure;
else
    for iRow = 1:row,
        for jCol = 1:col,
            names = fieldnames(oldStructure(iRow, jCol));
            if isempty(names)
                newStructure(iRow, jCol) = oldStructure(iRow, jCol);
            else
                for kFields = 1:length(names) % Recursive call
                    newStructure(iRow, jCol).(names{kFields}) = stringReplace(oldStructure(iRow, jCol).(names{kFields}),oldString, newString);
                end
            end
        end
    end
end
end
