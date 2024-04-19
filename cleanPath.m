function fixedPath = cleanPath(inPath)
% FORMAT fixedPath = cleanPath(inPath)
% Removes extra slashes from inPath.
%
% Inputs:
% inPath:       Path string to be cleaned of extra slashes.
%
% Outputs:
% fixedPath:    Path string after cleaning.
%
%
% 130101 Created by Benjamin Geib
% 141223 Modified by Taylor Salo to work with paths containing files

[filePath, fileName, fileSuffix] = fileparts(inPath);

if ~isempty(fileSuffix)
    fileParts = regexp(filePath, '/', 'split');
else
    fileParts = regexp(inPath, '/', 'split');
end

fileParts = fileParts(~cellfun('isempty', fileParts));
fixedPath = '';
for iFolder = 1:length(fileParts)
    fixedPath = [fixedPath '/' fileParts{iFolder}]; 
end
fixedPath = [fixedPath '/'];

if ~isempty(fileSuffix)
    fixedPath = [fixedPath fileName fileSuffix];
end
end
