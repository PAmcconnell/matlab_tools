function makeDirectoryTree(directory)
% FORMAT makeDirectoryTree(directory)
% Makes a directory. If path does not exist, makes every folder in path to
% create whole directory tree. Be careful, as it will make many unwanted
% folders if there is a typo in directory.
%
% Inputs:
% directory:    Folder to be created. If any folder in path does not exist,
%               it and all necessary subfolders will be made. String.
%
%
% 130101 Created by Benjamin Geib

parsedTree = regexp(directory, '/', 'split');
subFolders = parsedTree(~cellfun('isempty', parsedTree));

folderSearch = '/';
for iFolder = 1:length(subFolders)
	folderSearch = [folderSearch subFolders{iFolder} '/'];
    if ~exist(folderSearch, 'dir')
        mkdir(folderSearch);
    end
end
