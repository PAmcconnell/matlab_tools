function correctCsv(csvFile)
% FORMAT correctCsv(csvFile)
% Removes quotation marks from csv files. Sometimes they're added by
% OpenOffice or LibreOffice to delimit text.
% Dependencies: readCsv.m, stringReplace.m, writeCsv.m
%
% Inputs:
% csvFile:      CSV file to be corrected. String.
%
%
% 140926 Created by Taylor Salo

csvData = readCsv(csvFile);
csvData = stringReplace(csvData, '"', '');
writeCsv(csvData, csvFile);
end

