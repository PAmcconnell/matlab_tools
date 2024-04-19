function [studyFolder, projectFolder] = defineWrkDir(study, task)
% FORMAT [studyFolder, projectFolder] = defineWrkDir(study, task)
% A simple switch case statement that defines the working directory
% according to study.
% Dependencies: none
%
% Inputs:
% study:            The study.
% task:             The task.
%
% Outputs:
% studyFolder:      Path to study folder.
% projectFolder:    Path to where project folders are kept.
%
%
% 140801 Created by Taylor Salo

if ~exist('task','var')
    task = '';
end

switch lower(study)
    case 'cntracs'
        studyFolder = '/nfs/cntracs/';
        projectFolder = [studyFolder task '/project_folders/'];
    case 'ep'
        studyFolder = '/nfs/ep/EP_Processing/';
        projectFolder = [studyFolder task '/project_folders/'];
    case 'ep2'
        studyFolder = '/nfs/ep2/';
        projectFolder = [studyFolder task '/project_folders/'];
    case 'pact'
        studyFolder = '/nfs/pact/';
        projectFolder = [studyFolder 'project_folders/'];
    case 'agg'
        studyFolder = '/nfs/pact/aggression/';
        projectFolder = [studyFolder task '/project_folders/'];
    case 'emocs'
        studyFolder = '/nfs/emocs/';
        projectFolder = [studyFolder 'project_folders/'];
    otherwise
        error('I do not know this study...');
end
end