function [OptionalParameterIsolatedList, ...
    OptionalParameterDeletedList] = ...
    SeparateOptionalParameter...
    (OptionalParameterList, OptionalParameterName)
%% Tool for separating an optional optional parameter 
%% from the rest
% 
% Author: Žan Kogovšek
% Date: 1.11.2023
% Last changed: 2.10.2024
% 
%% Description
% 
% Given the cell array of optional parameters 
% 'OptionalParameterList' and the name 
% 'OptionalParameterName' of one of the optional parameters 
% in the cell array 'OptionalParameterList', this function returns 
% two cell arrays: the 'OptionalParameterIsolatedList' cell array 
% containing the name 'OptionalParameterName' followed by 
% the optional parameter itself, and the 
% 'OptionalParameterDeletedList' cell array which is the same 
% as the 'OptionalParameterList' cell array, except that it lacks 
% both the name 'OptionalParameterName' and the opional 
% parameter itself. 
% 
%% Variables
% 
% This function has the form of 
% [OptionalParameterIsolatedList, ...
% OptionalParameterDeletedList] = ...
% SeparateOptionalParameter...
% (OptionalParameterList, OptionalParameterName)
% 
% 'OptionalParameterList' is a row cell array of optional 
% parameters. It is supposed to have the form of a series of 
% strings which are the names of the optional parameters, each 
% of which is followed by the actual optional parameters (i.e. 
% {''OptionalParameter1'', 'OptionalParameter1', 
% ''OptionalParameter2'', 'OptionalParameter2', ..., 
% 'OptionalParameterName', 'OptionalParameter',  ..., 
% ''OptionalParameterN'', 'OptionalParameterN'). In principle, it 
% only has to be either an empty cell array or a row cell array. 
% 
% ''OptionalParameterName'' is the name of the optional 
% parameter. It must be a string. 
% 
% 'OptionalParameterIsolatedList' is a cell array. If the name 
% ''OptionalParameterName'' is not contained in the 
% 'OptionalParameterList' cell array, it is an empty cell array. If 
% the name 'OptionalParameterName' is contained in the 
% 'OptionalParameterList' cell array, it is a row cell array with two 
% elements. The first is the name 'OptionalParameterName' of 
% the optional parameter and the second is the optional 
% parameter 'OptionalParameter' itself. 
% 
% 'OptionalParameterDeletedList' is the same row cell array 
% as 'OptionalParameterList' except that it lacks the elements 
% the name 'OptionalParameterName' of the optional parameter 
% and the optional parameter 'OptionalParameter' itself. 


pars = inputParser;
paramName = 'OptionalParameterList';
errorMsg = '''OptionalParameterList'' must be a row cell array.';
validationFcn = @(x)assert...
    (iscell(OptionalParameterList) && ...
    size(OptionalParameterList, 1) < 2, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OptionalParameterName';
errorMsg = ...
    '''OptionalParameterName'' must be a character array.';
validationFcn = @(x)assert...
    (ischar(OptionalParameterName), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, OptionalParameterList, OptionalParameterName);


OptionalParameterIndex = find...
    (strcmp(OptionalParameterList, OptionalParameterName));

% In the following block of code, the 
% 'OptionalParameterDeletedList' is created firstly by being 
% identical to the cell array 'OptionalParameterList', after which 
% both the name 'OptionalParameterName' and the optional 
% parameter 'OptionalParameter' itself are deleted from the 
% 'OptionalParameterDeletedList' cell array. 
OptionalParameterDeletedList = OptionalParameterList;
OptionalParameterDeletedList...
    (OptionalParameterIndex : OptionalParameterIndex + 1) ...
    = [];

OptionalParameterIsolatedList = OptionalParameterList...
    (OptionalParameterIndex : OptionalParameterIndex + 1);

end