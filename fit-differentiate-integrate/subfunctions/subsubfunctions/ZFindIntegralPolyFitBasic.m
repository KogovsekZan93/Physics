function [yIntegralPolyFit, varargout] = ...
    ZFindIntegralPolyFitBasic...
    (xData, yData, xIntegralPolyFit, PolyDegree)
%% Numerical polynomial regression-based indefinite 
%% integration tool
% 
% Author: Žan Kogovšek
% Date: 12.30.2022
% Last changed: 1.1.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the vector "yIntegralPolyFit" of the estimated values of 
% f("xIntegralPolyFit") - f("xIntegralPolyFit"(1)), where 
% "xIntegralPolyFit" is the input vector of values of the X 
% variable. The estimation is based on the polynomial 
% regression of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). 
% 
%% Variables
% 
% This function has the form of [yIntegralPolyFit, varargout] = ...
% ZFindIntegralPolyFitBasic...
% (xData, yData, xIntegralPolyFit, PolyDegree)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX)("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xIntegralPolyFit" is the vector of the values of the 
% independent variable X at which the values of the vector 
% f("xIntegralPolyFit") - f("xIntegralPolyFit"(1)) is to be 
% estimated. 
% The "xIntegralPolyFit" vector must be a column vector of real 
% numbers. The values of the "xIntegralPolyFit" vector must be 
% in ascending order. 
% 
% "PolyDegree" is the degree of the regression polynomial of 
% the data points represented by the pairs ("xData"(i), "yData"(i)), 
% which is the estimation of the f function. The "PolyDegree" 
% degree must be a nonnegative integer. 
% 
% "yIntegralPolyFit" is the column vector of the estimated values 
% of f("xIntegralPolyFit") - f("xIntegralPolyFit"(1)). 
% 
% "varargout" represents the optional output parameter 
% "pFitPolyFit", which is the vector of coefficients of the 
% "PolyDegree"-th degree regression polynomial of the data 
% points represented by the pairs ("xData"(i), "yData"(i)). 
% "pFitPolyFit" is a column vector of the form of 
% [a_"PolyDegree"; a_("PolyDegree" - 1); ...; a_1; a_0]. The 
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

paramName = 'xIntegralPolyFit';
errorMsg = ...
    '''xIntegralPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'PolyDegree';
errorMsg = '''PolyDegree'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >=0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xIntegralPolyFit, PolyDegree);

% In the following two lines, in the first line, the regression 
% polynomial coefficients of the data points which are 
% represented by the pairs ("xData"(i). "yData"(i)) are calculated. 
% In the second line, the coefficients of a polynomial which is 
% the integral of the regression polynomial are calculated. 
pFitPolyFit = (polyfit(xData, yData, PolyDegree))';
pIntegralPolyFit = CalculateIntegralPolynomialCoefficients...
    (pFitPolyFit);

yIntegralPolyFit = polyval(pIntegralPolyFit, xIntegralPolyFit);
yIntegralPolyFit = yIntegralPolyFit - yIntegralPolyFit(1);
varargout = {pFitPolyFit};

end