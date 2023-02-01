function [AdditionalParameterIsolatedList, ...
    AdditionalParameterDeletedList] = ...
    SeparateAdditionalParameter...
    (OptionalParameterList, AdditionalParameterName)
%% Tool for separating an additional optional parameter 
%% from the rest
% 
% Author: Žan Kogovšek
% Date: 1.11.2023
% Last changed: 2.1.2023
% 
%% Description
% 
% Given a cell array of optional parameters 
% "OptionalParameterList" and the name 
% "'AdditionalParameterName'" of one of the optional 
% parameters (from here on called "the additional parameter") in 
% the cell array "OptionalParameterList", this function returns two 
% cell arrays: the "AdditionalParameterIsolatedList" cell array 
% containing the name "'AdditionalParameterName'" followed by 
% the additional parameter itself, and the 
% "AdditionalParameterDeletedList" cell array which is the same 
% as the "OptionalParameterList" cell array, only that it lacks 
% both the name "'AdditionalParameterName'" and the additional 
% parameter. 
% 
%% Variables
% 
% This function has the form of 
% [AdditionalParameterIsolatedList, ...
% AdditionalParameterDeletedList] = ...
% SeparateAdditionalParameter...
% (OptionalParameterList, AdditionalParameterName)
% 
% "OptionalParameterList" is a row cell array of optional 
% parameters. It is supposed to have the form of a series of 
% strings which are the names of the optional parameters, each 
% of which is followed by the actual optional parameters (i.e. 
% {"'OptionalParameter1'", "optionalParameter1", 
% "'OptionalParameter2'", "optionalParameter2", ..., 
% "'AdditionalParameterName'", "additionalParameter", 
% ...}). In principle, it only has to be either an empty cell array or a 
% row cell array. 
% 
% "'AdditionalParameterName'" is the name of the additional 
% parameter. It must be a string. 
% 
% "AdditionalParameterIsolatedList" is a cell array. If the name 
% "'AdditionalParameterName'" is not contained in the 
% "OptionalParameterList" cell array, it is an empty cell array. If 
% the name "'AdditionalParameterName'" is contained in the 
% "OptionalParameterList" cell array, it is a row cell array with two 
% elements. The first is the name "'AdditionalParameterName'" 
% of the additional parameter and the second is the additional 
% parameter "additionalParameter" itself. 
% 
% "AdditionalParameterDeletedList" is the same row cell array 
% as "OptionalParameterList" only that it lacks the elements the 
% name "'AdditionalParameterName'" of the additional 
% parameter and the additional parameter "additionalParameter" 
% itself. 


pars = inputParser;
paramName = 'OptionalParameterList';
errorMsg = '''OptionalParameterList'' must be a row cell array.';
validationFcn = @(x)assert...
    (iscell(OptionalParameterList) && ...
    size(OptionalParameterList, 1) < 2, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'AdditionalParameterName';
errorMsg = ...
    '''AdditionalParameterName'' must be a character array.';
validationFcn = @(x)assert...
    (ischar(AdditionalParameterName), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, OptionalParameterList, AdditionalParameterName);


AdditionalParameterIndex = find...
    (strcmp(OptionalParameterList, AdditionalParameterName));

% In the following block of code, the 
% "AdditionalParameterDeletedList" is created firstly by being 
% identical to the cell array "OptionalParameterList", after which 
% both the name "'AdditionalParameterName'" and the additional 
% parameter "additionalParameter" are deleted from the 
% "AdditionalParameterDeletedList" cell array. 
AdditionalParameterDeletedList = OptionalParameterList;
AdditionalParameterDeletedList...
    (AdditionalParameterIndex : AdditionalParameterIndex + 1) ...
    = [];

AdditionalParameterIsolatedList = OptionalParameterList...
    (AdditionalParameterIndex : AdditionalParameterIndex + 1);

end