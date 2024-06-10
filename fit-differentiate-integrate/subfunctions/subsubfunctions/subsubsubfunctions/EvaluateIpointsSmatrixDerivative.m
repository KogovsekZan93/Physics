function yDerivativeA = EvaluateIpointsSmatrixDerivative...
    (xData, yData, xDerivativeA, OrdDeriv, Ipoints, Smatrix)
%% Tool for evaluating the derivative of a piecewise interpolation 
%% polynomial
% 
% Author: Žan Kogovšek
% Date: 3.8.2023
% Last changed: 6.10.2024
% 
%% Description
% 
% Given the input 'OrdDeriv' parameter, and the input vector 'xData' of 
% the independent variable X and the input vector 'yData' of the values of 
% the dependent variable Y of an arbitrary function Y = f(X), this 
% function returns the vector 'yDerivativeA' of the values of 
% fA^('OrdDeriv')('xDerivativeA'), where fA^('OrdDeriv') is the 
% 'OrdDeriv'-th order derivative of the fA function and 'xDerivativeA' is 
% the input vector of values of the X variable. The fA function itself is 
% the input 'Ipoints' vector- and the input 'Smatrix' matrix-defined 
% piecewise interpolation polynomial of the data points represented by the 
% pairs ('xData'(i), 'yData'(i)). 
% 
%% Variables
% 
% This function has the form of yDerivativeA = ...
% EvaluateIpointsSmatrixDerivative...
% (xData, yData, xDerivativeA, OrdDeriv, Ipoints, Smatrix)
% 
% 'xData' and 'yData' are the vectors of the values of the independent 
% variable X and of the dependent variable Y, respectively, of an 
% arbitrary function Y = f(X) ('yData' = f('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column vectors of 
% equal length and of real numbers. The values of the 'xData' vector must 
% be in ascending order. 
% 
% 'xDerivativeA' is the vector of the values of the independent variable X 
% at which the yDerivativeA vector values of the fA^('OrdDeriv') function 
% are to be calculated. The fA^('OrdDeriv') function is the 'OrdDeriv'-th 
% derivative of the piecewise interpolation polynomial fA of the data 
% points represented by the pairs ('xData'(i), 'yData'(i)) and is defined 
% by the input variables the 'Ipoints' vector and the 'Smatrix' matrix. 
% Each polynomial p_i of which the fA function consists is the 
% interpolation polynomial of the points 
% ('xData'('Smatrix'(i, :)), 'yData'('Smatrix'(i, :))) and is defined over 
% the interval from 'Ipoints'(i) to 'Ipoints'(i + 1). 
% If a value 'xDerivativeA'(k) of the 'xDerivativeA' vector is the same as 
% one of the boundaries defined by the values of the 'Ipoints' vector 
% (i.e. 'xDerivativeA'(k) = 'Ipoints'(i)) , the corresponding value 
% 'yDerivative'(k) = fA^('OrdDeriv')('xDerivativeA'(k)) of the 
% 'yDerivative' vector will be that of the derivative of the polynomial 
% p_i for the 'xDerivativeA'(k) value (in other words, the polynomial p_i 
% on the right-side of the boundary is used for the calculation of 
% 'yDerivativeA'(k) value). 
% The 'xDerivativeA' vector must be a column vector of real numbers. The 
% values of the 'xDerivativeA' vector must be in ascending order. 
% 
% 'OrdDeriv' is the the value of the derivative order. It must be a 
% natural number. 
% 
% 'Ipoints' is the column vector of boundaries between the interpolation 
% polynomials of the piecewise interpolation polynomial fA. Any two 
% consecutive values of the 'Ipoints' vector 'Ipoints'(i) and 
% 'Ipoints'(i + 1) are the boundaries of i-th interpolation polynomial. It 
% must be a sorted column vector of numbers. 
% 
% 'Smatrix' is the matrix of rows of indices. Each row 'Smatrix'(i, :) 
% contains the indeces k of the data points ('xData'(k), 'yData'(k)) which 
% are used to construct the i-th interpolation polynomial p_i of the 
% piecewise interpolation polynomial fA. It must be a matrix of natural 
% numbers the height of which is length('Ipoints') - 1. 
% 
% 'yDerivativeA' is the column vector of the calculated values of 
% fA^('OrdDeriv')('xDerivativeA'). 


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
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativeA';
errorMsg = '''xDerivativeA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && issorted(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && issorted(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = ...
    '''Smatrix'' must be a matrix of natural numbers the hight of which is ''length(Ipoints) - 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    size(x, 1) == length(Ipoints) - 1 && any(any((mod(x,1) == 0))) && ...
    any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xDerivativeA, Ipoints, Smatrix);

xDerivativeALength = length(xDerivativeA);
yDerivativeA = zeros(xDerivativeALength, 1);

% In the following block of code, the index 'j' of the interpolation 
% polynomial p_'j' which defines the fA function over the interval from 
% 'Ipoints'('j' - 1) to 'Ipoints'('j') in which the value 
% 'xDerivativeA'(1) is contained is found. This way, useless calculation 
% of the coefficients of the derivatives of the interpolation polynomials 
% p_J for J < 'j' is avoided. 
j = 2;
while Ipoints(j) <= xDerivativeA(1)
    j = j +1;
end

% For each relevant interval of the X variable from 'Ipoints'('j' - 1) to 
% 'Ipoints'('j'), firstly the coefficients vector 'pDerivativeA' of the 
% polynomial which is the 'OrdDeriv'-th derivative of the interpolation 
% polynomial p_('j' - 1) of the data points 
% ('xData'('Smatrix'('j' - 1, :)), 'yData'('Smatrix'('j' - 1, :))) is 
% calculated by using the GetDerivativePolynomialCoefficients function. 
% Then, whenever in the for loop the value 'xDerivativeA'('b') exceeds the 
% right boundary of the relevant interval (i.e. 'Ipoints'('j')), the 
% 'yDerivativeA' vector is evaluated for the values of the 'xDerivativeA' 
% vector within the relevant interval. 
% Afterwards, the next interval in which the values of the 'xDerivativeA' 
% vector are contained is found and the process is repeated until the last 
% interval in which the values of the 'xDerivativeA' vector is contained 
% is found after which the last values of the 'yDerivativeA' vector are 
% calculated outside of the for loop. 
pDerivativeA = GetDerivativePolynomialCoefficients...
    (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)), OrdDeriv);
a = 1;
for b = 2 : xDerivativeALength
    if xDerivativeA(b) >= Ipoints(j)
        yDerivativeA(a : b - 1) = polyval...
            (pDerivativeA, xDerivativeA(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xDerivativeA(b)
            j = j +1;
        end
        a = b;
        pDerivativeA = GetDerivativePolynomialCoefficients...
            (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)), OrdDeriv);
    end
end
yDerivativeA(a : end) = polyval(pDerivativeA, xDerivativeA(a : end));

end