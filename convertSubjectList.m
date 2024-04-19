function outSubjectList = convertSubjectList(subjectList)
% FORMAT outSubjectList = convertSubjectList(subjectList)
% Converts subject lists from readCsv format to nSubjects x 2 cell array
% where one column is subject ID and the other is group.
%
% Inputs:
% subjectList:      Subject list in readCsv format.
%
% Outputs:
% outSubjectList:   Reformatted subject list.
%
%
% 150107 Created by Taylor Salo

counter = 1;
for iGroup = 1:length(subjectList)
    for jSubj = 1:length(subjectList{iGroup}.col)
        outSubjectList{counter, 1} = subjectList{iGroup}.col{jSubj};
        outSubjectList{counter, 2} = subjectList{iGroup}.header{1};
        counter = counter + 1;
    end
end

end

