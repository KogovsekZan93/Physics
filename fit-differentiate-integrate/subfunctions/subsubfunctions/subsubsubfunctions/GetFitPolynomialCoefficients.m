function p = GetFitPolynomialCoefficients(xData, yData)
%% Tool for obtaining the coefficients of the interpolation polynomial of 
%% the input data
% 
% Author: Žan Kogovšek
% Date: 2.5.2023
% Last changed: 6.10.2024
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X and the 
% input vector 'yData' of the values of the dependent variable Y of an 
% arbitrary function Y = f(X) ('yData' = f('xData')), this function 
% returns the vector 'p' of the coefficients of the polynomial which is 
% the interpolation polynomial of the data points represented by the pairs 
% ('xData'(i), 'yData'(i)). 
% 
%% Variables
% 
% This function has the form of p = GetFitPolynomialCoefficients...
% (xData, yData)
% 
% 'xData' and 'yData' are the vectors of the values of the independent 
% variable X and of the dependent variable Y, respectively, of an 
% arbitrary function Y = f(X) ('yData' = f('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column vectors of 
% equal length and of real numbers. The values of the 'xData' vector must 
% be in ascending order. 
% 
% 'p' is the vector of coefficients of the interpolation polynomial of the 
% data points represented by the pairs ('xData'(i), 'yData'(i)). The 'p' 
% vector is a column vector of the form of [a_(length('xData') - 1); 
% a_(length('xData') - 2); ...; a_1; a_0]. The polynomial can be evaluated 
% by the MATLAB polyval function. 


xDataLength = length(xData);

pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && issorted(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    xDataLength == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData);

M = ones(xDataLength);

for i = 1 : xDataLength - 1
    M(:, i) = power(xData, xDataLength - i );
end

p = linsolve(M, yData);

end