function subjectList = parseSubjects(subjectList, nBatches, batchNumber)
% FORMAT subjectList = parseSubjects(subjectList, nBatches, batchNumber)
% Splits a cell array based on number of divisions and which section you
% want. Returns that section. Used for splitting lists of subjects and
% parallel processing subject lists in batches.
% Dependencies: none.
%
% Inputs:
% subjectList:      List of subjects. Cell array or structure from readCsv.
% nBatches:         Number of batches into which the list is divided.
%                   Double.
% batchNumber:      Which section of the list you want. Double.
%                   Must be <= nBatches.
%
% Outputs:
% subjectList:      Section of input subjectList corresponding to
%                   batchNumber. Same format as input.
%
%
% 130101 Created by Benjamin Geib
% 141218 Modified by Taylor Salo

switch class(subjectList{1})
    case 'char'
        temporarySubjectList = subjectList;
    case 'struct'
        temporarySubjectList = subjectList{1}.col;
    otherwise
        error('ERROR: Invalid subject list\n');
end

nSubjects = length(temporarySubjectList);
parcel = int32(ceil(nSubjects / nBatches));
nSubjectsToRun = (((batchNumber - 1) * parcel) + 1):(batchNumber * parcel);
nSubjectsToRun(nSubjectsToRun>nSubjects) = []; % Prevent too long
switch class(subjectList{1})
    case 'char'
        for iSubj = 1:length(nSubjectsToRun)
            subjectsToUse{iSubj} = subjectList{nSubjectsToRun(iSubj)};
        end
        clear subj;
        subjectList = subjectsToUse;
    case 'struct'
        subjectsToUse{1}.header = 'subj';
        subjectsToUse{2}.header = 'pro';
        for iSubj = 1:length(nSubjectsToRun)
            subjectsToUse{1}.col(iSubj) = subjectList{1}.col(nSubjectsToRun(iSubj));
            subjectsToUse{2}.col(iSubj) = subjectList{2}.col(nSubjectsToRun(iSubj));
        end
        clear subj;
        subjectList = subjectsToUse;
end
end