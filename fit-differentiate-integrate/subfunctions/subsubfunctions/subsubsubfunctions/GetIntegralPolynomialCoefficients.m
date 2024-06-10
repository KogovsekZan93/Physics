function pIntegralA = GetIntegralPolynomialCoefficients(xData, yData)
%% Tool for obtaining the coefficients of the polynomial which is a 
%% definite integral of the interpolation polynomial of the input data
% 
% Author: Žan Kogovšek
% Date: 2.1.2023
% Last changed: 6.10.2024
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X and the 
% input vector 'yData' of the values of the dependent variable Y of an 
% arbitrary function Y = (df/dX)(X) ('yData' = (df/dX)('xData')), this 
% function returns the vector 'pIntegralA' of the coefficients of the 
% polynomial which is a definite integral of the interpolation polynomial 
% of the data points represented by the pairs ('xData'(i), 'yData'(i)). 
% The definite integral is such that its value at X = 0 is 0. 
% 
%% Variables
% 
% This function has the form of pIntegralA = ...
% GetIntegralPolynomialCoefficients(xData, yData)
% 
% 'xData' and 'yData' are the vectors of the values of the independent 
% variable X and of the dependent variable Y, respectively, of an 
% arbitrary function Y = (df/dX)(X) ('yData' = (df/dX)('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column vectors of 
% equal length and of real numbers. The values of the 'xData' vector must 
% be in ascending order. 
% 
% 'pIntegralA' is the vector of coefficients of the length('xData')-th 
% degree interpolation polynomial which is a definite integral of the 
% interpolation polynomial of the data  points represented by the pairs 
% ('xData'(i), 'yData'(i)). The definite integral is such that its value 
% at X = 0 is 0. 'pIntegralA' is a column vector of the form of 
% [a_length('xData'); a_(length('xData') - 1); ...; a_1; a_0]. The 
% polynomial can be evaluated by the MATLAB polyval function. 


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && issorted(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData);

pIntegralA = CalculateIntegralPolynomialCoefficients...
    (GetFitPolynomialCoefficients(xData, yData));

end