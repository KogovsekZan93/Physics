function [AdditionalParameterIsolatedList, ...
    AdditionalParameterDeletedList] = ...
    SeparateAdditionalParameter...
    (OptionalParameterList, AdditionalParameterName)
%% Tool for separating an additional optional parameter 
%% from the rest
% 
% Author: Žan Kogovšek
% Date: 1.11.2023
% Last changed: 11.7.2023
% 
%% Description
% 
% Given the cell array of optional parameters 
% 'OptionalParameterList' and the name 
% 'AdditionalParameterName' of one of the optional parameters 
% (from here on referred to as "the additional parameter") in 
% the cell array 'OptionalParameterList', this function returns two 
% cell arrays: the 'AdditionalParameterIsolatedList' cell array 
% containing the name 'AdditionalParameterName' followed by 
% the additional parameter itself, and the 
% 'AdditionalParameterDeletedList' cell array which is the same 
% as the 'OptionalParameterList' cell array, except that it lacks 
% both the name 'AdditionalParameterName' and the additional 
% parameter itself. 
% 
%% Variables
% 
% This function has the form of 
% [AdditionalParameterIsolatedList, ...
% AdditionalParameterDeletedList] = ...
% SeparateAdditionalParameter...
% (OptionalParameterList, AdditionalParameterName)
% 
% 'OptionalParameterList' is a row cell array of optional 
% parameters. It is supposed to have the form of a series of 
% strings which are the names of the optional parameters, each 
% of which is followed by the actual optional parameters (i.e. 
% {''OptionalParameter1'', 'OptionalParameter1', 
% ''OptionalParameter2'', 'OptionalParameter2', ..., 
% 'AdditionalParameterName', 'AdditionalParameter',  ..., 
% ''OptionalParameterN'', 'OptionalParameterN'). In principle, it 
% only has to be either an empty cell array or a row cell array. 
% 
% ''AdditionalParameterName'' is the name of the additional 
% parameter. It must be a string. 
% 
% 'AdditionalParameterIsolatedList' is a cell array. If the name 
% ''AdditionalParameterName'' is not contained in the 
% 'OptionalParameterList' cell array, it is an empty cell array. If 
% the name 'AdditionalParameterName' is contained in the 
% 'OptionalParameterList' cell array, it is a row cell array with two 
% elements. The first is the name 'AdditionalParameterName' of 
% the additional parameter and the second is the additional 
% parameter 'AdditionalParameter' itself. 
% 
% 'AdditionalParameterDeletedList' is the same row cell array 
% as 'OptionalParameterList' except that it lacks the elements 
% the name 'AdditionalParameterName' of the additional 
% parameter and the additional parameter 'AdditionalParameter' 
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
% 'AdditionalParameterDeletedList' is created firstly by being 
% identical to the cell array 'OptionalParameterList', after which 
% both the name 'AdditionalParameterName' and the additional 
% parameter 'AdditionalParameter' itself are deleted from the 
% 'AdditionalParameterDeletedList' cell array. 
AdditionalParameterDeletedList = OptionalParameterList;
AdditionalParameterDeletedList...
    (AdditionalParameterIndex : AdditionalParameterIndex + 1) ...
    = [];

AdditionalParameterIsolatedList = OptionalParameterList...
    (AdditionalParameterIndex : AdditionalParameterIndex + 1);

end