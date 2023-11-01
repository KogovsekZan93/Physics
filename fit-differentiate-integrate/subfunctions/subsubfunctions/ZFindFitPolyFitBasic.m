function [yFitPolyFit, varargout] = ZFindFitPolyFitBasic...
    (xData, yData, xFitPolyFit, PolyDegree)
%% Polynomial regression-based curve fitting tool
% 
% Author: Žan Kogovšek
% Date: 1.1.2023
% Last changed: 11.1.2023
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X 
% and the input vector 'yData' of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector 'yFitPolyFit' of the estimated values of 
% f('xFitPolyFit'), where 'xFitPolyFit' is the input vector of values 
% of the X variable. The estimation is based on the polynomial 
% regression interpolation of the data points represented by the 
% pairs ('xData'(i), 'yData'(i)). 
% 
%% Variables
% 
% This function has the form of [yFitPolyFit, varargout] = ...
% ZFindFitPolyFitBasic(xData, yData, xFitPolyFit, PolyDegree)
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ('yData' = f('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. The values of the 
% 'xData' vector must be in ascending order. 
% 
% 'xFitPolyFit' is the vector of the values of the independent 
% variable X at which the value of the f function is to be 
% estimated. The 'xFitPolyFit' vector must be a column vector 
% of real numbers. 
% 
% 'PolyDegree' is the degree of the regression polynomial of 
% the data points represented by the pairs ('xData'(i), 'yData'(i)), 
% which is the estimation of the f function. The 'PolyDegree' 
% degree must be a nonnegative integer. 
% 
% 'yFitPolyFit' is the column vector of the estimated values of 
% f('xFitPolyFit'). 
% 
% 'varargout' represents the optional output parameter 
% 'pFitPolyFit', which is the vector of coefficients of the 
% 'PolyDegree'-th degree regression polynomial of the data 
% points represented by the pairs ('xData'(i), 'yData'(i)). 
% 'pFitPolyFit' is a column vector of the form of 
% [a_'PolyDegree'; a_('PolyDegree' - 1); ...; a_1; a_0]. The 
% regression polynomial can be evaluated by the MATLAB 
% polyval function. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFit';
errorMsg = ...
    '''xFitPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'PolyDegree';
errorMsg = '''PolyDegree'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >=0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xFitPolyFit, PolyDegree);

pFitPolyFit = (polyfit(xData, yData, PolyDegree))';

yFitPolyFit = polyval(pFitPolyFit, xFitPolyFit);
varargout = {pFitPolyFit};

end