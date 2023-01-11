function [AdditionalParameterIsolatedList, ...
    AdditionalParameterDeletedList] = ...
    SeparateAdditionalParameter...
    (OptionalParameterList, AdditionalParameterName)
%% Tool for separating an additional optional parameter ...
%% from the rest
% 
% Author: Žan Kogovšek
% Date: 1.11.2023
% Last changed: 1.11.2023
% 
%% Description
% 
% Given a cell array of optional parameters 
% "OptionalParameterList" and the name 
% "AdditionalParameterName" of one of the optional parameters 
% (from here on called "the additional parameter") in the cell 
% array "OptionalParameterList", this function returns two cell 
% arrays: the "AdditionalParameterIsolatedList" cell array 
% containing the name "AdditionalParameterName" followed by 
% the additional parameter itself, and the 
% "AdditionalParameterDeletedList" cell array which is the same 
% as the "OptionalParameterList" cell array, only that it lacks 
% both the name "AdditionalParameterName" and the additional 
% parameter. 
% 
% 
%% Variables
% 
% This function has the form of 
% [AdditionalParameterIsolatedList, ...
% AdditionalParameterDeletedList] = ...
% SeparateAdditionalParameter...
% (OptionalParameterList, AdditionalParameterName)
% 
% "Limits" must be a column vector of two real numbers. It is 
% supposed to be the vector of the limits of integration with the 
% value "Limits"(1) the lower limit and the value "Limits"(2) the 
% upper limit of integration. 
% 
% "LimitsSorted" is a column vector of two real numbers with the 
% same values as the "Limits" vector, only in ascending order. 
% 
% "LimitOrder" is a scalar with the value of 1 if 
% "Limits" = "LimitsSorted" and -1 if "Limits" != "LimitsSorted". 
% 
% The "ColorFace" parameter is a row vector of three real 
% numbers which represents the RGB triplet which is to be used 
% to set the color of the area under the curve plotted by the 
% DrawZIntegral… functions. It is blue if "LimitOrder" == 1 and 
% red if "LimitOrder" == -1. 


pars = inputParser;

paramName = 'OptionalParameterList';
errorMsg = '''OptionalParameterList'' must be a cell array.';
validationFcn = @(x)assert...
    (iscell(OptionalParameterList), errorMsg);
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

AdditionalParameterDeletedList = OptionalParameterList;
AdditionalParameterDeletedList...
    (AdditionalParameterIndex : AdditionalParameterIndex + 1) ...
    = [];

AdditionalParameterIsolatedList = OptionalParameterList...
    (AdditionalParameterIndex : AdditionalParameterIndex + 1);

end