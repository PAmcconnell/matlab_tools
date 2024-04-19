function linearIndex = subv2ind(sizeArray, subscriptVector)
% FORMAT linearIndex = subv2ind(sizeArray, subscriptVector)
% Return linear indexes into an ND-array given by a vector of positions.
%
% Inputs:
% sizeArray:		Dx1 or 1xD.
% subscriptVector:	NxD. Each row specifies an element in an array
%						 with dimensions sizeArray.
%
% Outputs:
% linearIndex:		Nx1. Linear indexes specifying the same elements.
%
% Matlab's sub2ind returns the scalar linear indexes corresponding to an
% argument list of subscripts giving the rows, cols, 3rd-dims, ... of each
% element. In code that deals with multi-dimensional arrays, it is common to
% have the subscripts stored in a rows of an array. This function will take the
% subscripts in a single array and give the corresponding linear indexes for a
% given array size, sizeArray.
%
% See also: ind2subv, ind2sub, sub2ind

% Iain Murray, November 2007, March 2011

if (size(subscriptVector, 2) ~= numel(sizeArray))
    error('subscripts are wrong length for stated array dimensions.');
end

subscripts = num2cell(subscriptVector, 1);
linearIndex = sub2ind(sizeArray(:)', subscripts{:});
