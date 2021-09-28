function [LimitsSorted, LimitOrder, ColorFace] = IntegrationLimitsSort(Limits)
%INTEGRATIONLIMITSSORT Summary of this function goes here
%   Detailed explanation goes here


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