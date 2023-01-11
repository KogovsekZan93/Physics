function [LimitsSorted, LimitOrder, ColorFace] = ...
    SortIntegrationLimits(Limits)
%% Tool for sorting the limits of integration in ascending 
%% order
% 
% Author: Žan Kogovšek
% Date: 1.11.2023
% Last changed: 1.11.2023
% 
%% Description
% 
% Given the input vector "Limits" of two values, this function 
% returns the vector "LimitsSorted" with the same two values as 
% the vector "Limits" but in ascending order. The value of 
% "LimitOrder" is 1 if "Limits" == "LimitsSorted", and -1 if 
% "Limits"(1) == "LimitsSorted"(2) and 
% "Limits" (2) == "LimitsSorted"(1). "ColorFace" is the 
% parameter that determines the color of the area under the 
% curve plotted by the DrawZIntegral... functions depending on 
% the "LimitOrder" parameter. 
% 
%% Variables
% 
% This function has the form of [LimitsSorted, LimitOrder, ...
% ColorFace] = SortIntegrationLimits(Limits)
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

paramName = 'Limits';
errorMsg = '''Limits'' must be a column vector of two numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) ...
    && length(Limits) == 2, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, Limits);

LimitOrder = 1;
LimitsSorted = Limits;

ColorFace = [0, 0, 1];
if Limits(2) < Limits(1)
    LimitOrder = -1;
    LimitsSorted = Limits([2; 1]);
    ColorFace = [1, 0, 0];
end

end