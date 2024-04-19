function MergedStructure = mergeStructures(Structure1, index1, Structure2, index2, name)
% FORMAT MergedStructure = mergeStructures(Structure1, index1, Structure2, index2, name)
% Merges two structures in excel format based on columns defined by index1
% and index2, with outputted merged column named after name.
%
% Inputs:
% Structure1:       The first structure
% index1:           Index of the first structure's intersect column
% Structure2:       The second structure
% index2:           Index of the second structure's intersect column
% name:             Name of the merged column in the outputted structure
%
% Outputs:
% MergedStructure:  Merged structures
%
% Assumptions:
% 1. Structures are in the format in which there are two fields, one for
%    the header and one for the col data.
% 2. Duplicate data DNE.
%
%
% 130101 Created by Benjamin Geib

missingDataString = 'NoData';
removeDuplicates = 0;

Structure1 = fillStructure(Structure1);
Structure2 = fillStructure(Structure2);

% 1) Assume that IDs of some kind are being matched. Because of this, make
% sure that no spaces or empties have been snuck in.
indexColumnStructure1 = removeEmptyCells(Structure1{index1}.col);
indexColumnStructure2 = removeEmptyCells(Structure2{index2}.col);
indexColumnAllValues = unique(union(indexColumnStructure1, indexColumnStructure2)); % A list of all IDs

% 2) Set up the expected headers and classes
columnCounter = 1;
MergedStructure{columnCounter}.header = name;
MergedStructure{columnCounter}.col = indexColumnAllValues;
dataType{columnCounter} = class(MergedStructure{1}.col{1});
columnCounter = columnCounter + 1;

headerIndexStructure1 = setdiff(1:length(Structure1), index1);
headerIndexStructure2 = setdiff(1:length(Structure2), index2);

for iCol = headerIndexStructure1
	MergedStructure{columnCounter}.header = Structure1{iCol}.header;
	dataType{columnCounter} = class(Structure1{iCol}.col(1));
	columnCounter = columnCounter + 1;
end

for iCol = headerIndexStructure2
	MergedStructure{columnCounter}.header = Structure2{iCol}.header;
	dataType{columnCounter} = class(Structure2{iCol}.col(1));
	columnCounter = columnCounter + 1;
end

% Fill in MergedStructure
for iRow = 1:length(MergedStructure{1}.col) % Loop through all the subjects
	cellValue = MergedStructure{1}.col{iRow};
    columnCounter = 2;
	[columnCounter, MergedStructure] = appendStructure(iRow, columnCounter,...
        MergedStructure, dataType, Structure1, index1, headerIndexStructure1, cellValue, missingDataString);
	[~, MergedStructure] = appendStructure(iRow, columnCounter, MergedStructure,...
        dataType, Structure2, index2, headerIndexStructure2, cellValue, missingDataString);
end

% Optional removal of duplicates.
if removeDuplicates == 1
    for iCol = 1:length(MergedStructure)
        allHeaders{iCol} = MergedStructure{iCol}.header;
    end
	[~, intersection, ~] = intersect(unique(allHeaders), allHeaders);
	killIndex = setdiff(1:length(allHeaders), intersection);
	ReducedStructure = removeData(killIndex, MergedStructure, 'col');	
end
end

function [headerCounter, MergedStructure] = appendStructure(rowNumber, headerCounter,...
    MergedStructure, dataType, Data, index, headerIndex, cellValue, missingDataString)
% FORMAT [headerCounter, MergedStructure] = appendStructure(rowNumber, headerCounter,...
%   MergedStructure, dataType, Data, index, headerIndex, cellValue, missingDataString)
% Appends structure Data to MergedStructure.
%
%
% 130101 Created by Benjamin Geib

% 1) Check to see if the subject has data in struct1
valueIndex = find(strcmp(cellValue, Data{index}.col));
if length(valueIndex) > 1
    fprintf(['\tWarning: Duplicates of "' cellValue '" exist, pulling from first index\n']);
    valueIndex = valueIndex(1);
end
% 2) if output is discovered then it needs to be consolidated
if ~isempty(valueIndex)	
    for iCol = 1:length(headerIndex)
        switch dataType{headerCounter}
            case 'char'
                MergedStructure{headerCounter}.col(rowNumber) = Data{headerIndex(iCol)}.col(valueIndex);
            case 'double'
                MergedStructure{headerCounter}.col(rowNumber) = Data{headerIndex(iCol)}.col(valueIndex);
            case 'cell'
                MergedStructure{headerCounter}.col{rowNumber} = Data{headerIndex(iCol)}.col{valueIndex};
        end
        headerCounter = headerCounter + 1;
    end
else
    for iCol = 1:length(headerIndex)
        switch dataType{headerCounter}
            case 'char'
                MergedStructure{headerCounter}.col(rowNumber) = missingDataString;
            case 'double'
                MergedStructure{headerCounter}.col(rowNumber) = missingDataString;
            case 'cell'
                MergedStructure{headerCounter}.col{rowNumber} = missingDataString;
        end
        headerCounter = headerCounter + 1;
    end
end
end

function Structure = fillStructure(Structure)
% FORMAT Structure = fillStructure(Structure)
% Takes excel format structure (1xn cell array of structures with fields header
% and col, where each header is a cell and each col is a 1xm cell array
% filled with data) and adds empty cells to subsequent cols to be same length as 
% first col. Structures read in from a file should not have nonmatching col
% lengths, but there are surely some circumstances where this is useful.
%
%
% 130101 Created by Benjamin Geib

if isempty(Structure)
    return
end

if isfield(Structure{1}, 'col')
    if ~isempty(Structure)
        nRowsFirstCol = length(Structure{1}.col);
        for iCol = 2:length(Structure)
            nRowsCurrentCol = length(Structure{iCol}.col);
            if nRowsCurrentCol < nRowsFirstCol
                for jRow = nRowsCurrentCol + 1:nRowsFirstCol
                    switch class(Structure{iCol}.col)
                        case 'cell'
                            Structure{iCol}.col{jRow} = '';
                        case 'double'
                            Structure{iCol}.col(jRow) = NaN;
                    end
                end
            end
        end
    end
else
	fprintf('--Flush Struct--\n=> Failed to run due to lack of field "col"\n');
end
end

function outCellArray = removeEmptyCells(cellArray)
% FORMAT outCellArray = removeEmptyCells(cellArray)
% A very simple function to remove empty cells from cell arrays. Great for
% subject lists.
%
%
% 140801 Created by Taylor Salo

for iCell = 1:length(cellArray)
    cellArray{iCell} = cellArray{iCell}(~isspace(cellArray{iCell}));
    if isfield(cellArray{iCell}, 'col')
        cellArray{iCell}.col = removeEmptyCells(cellArray{iCell}.col);
    end
end

outCellArray = cellArray(~cellfun('isempty', cellArray));
end

function ReducedStructure = removeData(index, OriginalStructure, rowOrCol)
% FORMAT ReducedStructure = removeData(index, OriginalStructure, rowOrCol)
% This function removes either rows or columns from a data structure.
%
% Inputs:
% index:                Kill index (remove these)
% OriginalStructure:    Original structure
% rowOrCol:             'row' or 'col' specification
%
% Outputs:
% ReducedStructure:     Reduced structure
%
%
% 130101 Created by Benjamin Geib
switch rowOrCol
    case 'row'
        % Reform headers
        for iCol = 1:length(OriginalStructure)
            ReducedStructure{iCol}.header = OriginalStructure{iCol}.header;
        end
        rowCounter = 1;
        for iRow = 1:length(OriginalStructure{1}.col)
            nToKill = sum(index == iRow);
            if nToKill == 0
                for jCol = 1:length(OriginalStructure)
                    try
                        ReducedStructure{jCol}.col{rowCounter} = OriginalStructure{jCol}.col{iRow};
                    catch err
                        ReducedStructure{jCol}.col(rowCounter) = OriginalStructure{jCol}.col(iRow);
                    end
                end
                rowCounter = rowCounter + 1;
            end
        end
    case 'col'
        columnCounter = 1;
        saveIndex = setdiff(1:length(OriginalStructure), index);
        for iCol = saveIndex
            ReducedStructure{columnCounter}.header = OriginalStructure{iCol}.header;
            ReducedStructure{columnCounter}.col = OriginalStructure{iCol}.col;
            columnCounter = columnCounter + 1;
        end
    otherwise
        fprintf('Warning: no changes made, rc must be "row" or "col"\n');
end
end