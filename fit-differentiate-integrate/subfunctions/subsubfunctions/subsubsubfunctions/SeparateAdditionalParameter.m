function [OptionalAdditionalIsolatedList, AdditionalParameterDeletedList] = SeparateAdditionalParameter(AdditionalParameterList, Parameter)
%DELETEOPTIONALVARIABLE Summary of this function goes here
%   Detailed explanation goes here
% iscell(A)
% OptionalParameterList


pars = inputParser;

paramName = 'AdditionalParameterList';
errorMsg = '''AdditionalParameterList'' must be a cell array.';
validationFcn = @(x)assert(iscell(AdditionalParameterList), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Parameter';
errorMsg = '''Parameter'' must be a character array.';
validationFcn = @(x)assert(ischar(Parameter), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, AdditionalParameterList, Parameter);


AdditionalParameterIndex = find(strcmp(AdditionalParameterList, Parameter));

AdditionalParameterDeletedList = AdditionalParameterList;
AdditionalParameterDeletedList(AdditionalParameterIndex : AdditionalParameterIndex + 1) = [];

OptionalAdditionalIsolatedList = AdditionalParameterList(AdditionalParameterIndex : AdditionalParameterIndex + 1);

end