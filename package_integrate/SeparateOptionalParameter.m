function [OptionalParameterIsolatedList, OptionalParameterDeletedList] = SeparateOptionalParameter(OptionalParameterList, Parameter)
%DELETEOPTIONALVARIABLE Summary of this function goes here
%   Detailed explanation goes here
OptionalParameterIndex = find(strcmp(OptionalParameterList, Parameter));

OptionalParameterDeletedList = OptionalParameterList;
OptionalParameterDeletedList(OptionalParameterIndex : OptionalParameterIndex + 1) = [];

OptionalParameterIsolatedList = OptionalParameterList(OptionalParameterIndex : OptionalParameterIndex + 1);

end