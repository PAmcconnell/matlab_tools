function smartError(error)
% FORMAT smartError(error)
% Reports errors from try/catch statements in an understandable format.
%
% Inputs:
% error:        Error output from try/catch statement.
%
%
% 130101 Created by Benjamin Geib

fprintf('\n--MATLAB ERROR--\n');
fprintf('Error: %s\n', error.message);
if ~isempty(error.stack)
	fprintf('Error in: %s @ line %d\n\n', error.stack(1).name, error.stack(1).line);
else
	fprintf('\n');
end
end
