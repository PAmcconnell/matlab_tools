function index = strsearch(string, cellArray)
% FORMAT index = strsearch(string, cellArray)
% Searches a cell array for a string and returns indices of the positon.
%
% Inputs:
% string:       The string for which to search.
% cellArray:    The cell array through which to search.
%
% Outputs:
% index:        Index of cells where string was found.
%
%
% 121001 Created by Benjamin Geib
% 150107 Modified by Taylor Salo

index = find(~cellfun('isempty', strfind(cellArray, string)));
end
