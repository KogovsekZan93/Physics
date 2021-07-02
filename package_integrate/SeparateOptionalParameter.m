function [OptionalParameterIsolatedList, OptionalParameterDeletedList] = SeparateOptionalParameter(OptionalParameterList, Parameter)
%DELETEOPTIONALVARIABLE Summary of this function goes here
%   Detailed explanation goes here
% iscell(A)
% OptionalParameterList


pars = inputParser;

paramName = 'OptionalParameterList';
errorMsg = '''OptionalParameterList'' must be a cell array.';
validationFcn = @(x)assert(iscell(OptionalParameterList), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Parameter';
errorMsg = '''Parameter'' must be a character array.';
validationFcn = @(x)assert(ischar(Parameter), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, OptionalParameterList, Parameter);


OptionalParameterIndex = find(strcmp(OptionalParameterList, Parameter));

OptionalParameterDeletedList = OptionalParameterList;
OptionalParameterDeletedList(OptionalParameterIndex : OptionalParameterIndex + 1) = [];

OptionalParameterIsolatedList = OptionalParameterList(OptionalParameterIndex : OptionalParameterIndex + 1);

end