function yIntegralA = EvaluateIpointsSmatrixIntegral...
    (xData, yData, xIntegralA, Ipoints, Smatrix)
%% Tool for evaluating the definite integral of a piecewise 
%% interpolation polynomial from "xIntegralA"(1) to 
%% "xIntegralA"
% 
% Author: Žan Kogovšek
% Date: 2.8.2023
% Last changed: 2.13.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the vector "yIntegralA" of values "yIntegralA"(j) each of 
% which is the definite integral of a piecewise polynomial dfA/dX 
% from "xIntegralA"(1) to xIntegralA"(j), where "xIntegralA" is the 
% input vector of values of the X variable. The dfA/dX piecewise 
% polynomial consists of the interpolation polynomials p_i of the 
% data points which are represented by the pairs 
% ("xData"("Smatrix"(i, :)), "yData"("Smatrix"(i, :))) which are 
% defined from "Ipoints"(i) to "Ipoints"(i + 1). "Smatrix" is an input 
% matrix of indices and Ipoints is an input vector of values of the 
% X variable. 
% 
%% Variables
% 
% This function has the form of yIntegralA = ...
% EvaluateIpointsSmatrixIntegral...
% (xData, yData, xIntegralA, Ipoints, Smatrix)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX)("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xIntegralA" is the vector of the values of the independent 
% variable X at which the values of the vector 
% fA("xIntegralA") - fA("xIntegralA"(1)) is to be calculated. 
% The "xIntegralA" vector must be a column vector of real 
% numbers. The values of the "xIntegralA" vector must be in 
% ascending order. 
% 
% "Ipoints" is a column vector of boundaries between the 
% interpolation polynomials of the piecewise interpolation 
% polynomial dfA/dX. Any two consecutive values of the 
% "Ipoints" vector "Ipoints"(i) and "Ipoints"(i + 1) are the 
% boundaries of i-th interpolation polynomial. It must be a sorted 
% column vector of numbers. 
% 
% "Smatrix" is the matrix of rows of indices. Each row 
% "Smatrix"(i, :) contains the indeces k of the data points 
% ("xData"(k), "yData"(k)) which were used to construct the i-th 
% interpolation polynomial p_i of the piecewise interpolation
% polynomial fA/dX. It must be a matrix of natural numbers the 
% hight of which is length("Ipoints") - 1. 
% 
% "yIntegralA" is the column vector of the values 
% fA("xIntegralA") - fA("xIntegralA"(1)), where fA is an indefinite 
% integral of the dfA/dX function. In other words, each value 
% "yIntegralA"(i) is the value of the definite integral over the 
% independent variable X of the dfA/dX function from the value 
% "xData"(1) to " xData"(i). 


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

paramName = 'xIntegralA';
errorMsg = ...
    '''xIntegralA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = ...
    '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = ...
    '''Smatrix'' must be a matrix of natural numbers the hight of which is ''length(Ipoints) - 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    size(x, 1) == length(Ipoints) - 1 && ...
    any(any((mod(x,1) == 0))) && any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xIntegralA, Ipoints, Smatrix);

xIntegralALength = length(xIntegralA);
yIntegralA = zeros(xIntegralALength, 1);

% In the following block of code, the index of the upper 
% boundary "j" of the interval ("Ipoints"("j" - 1), "Ipoints"("j")) in 
% which the value lowest value of the "xData" vector (i.e. the 
% "xData"(1) value) is found. This is how the first relevant interval 
% ("Ipoints"("j" - 1), "Ipoints"("j")) and polynomial p_("j" - 1) is 
% determined so no further consideration is required for intervals 
% ("Ipoints"(J - 1), "Ipoints"(J)) and corresponding polynomials 
% p_(J - 1) for J < "j". 
j = 2;
while Ipoints(j) <= xIntegralA(1)
    j = j +1;
end

% In the following line, the coefficients of the polynomial which is 
% the integral of the polynomial p_("j" - 1) are determined. 
pIntegralA = GetIntegralPolynomialCoefficients...
    (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));


Summa = 0;
a = 1;
for b = 2 : xIntegralALength
    if xIntegralA(b) >= Ipoints(j)
        yIntegralA(a : b - 1) = Summa + ...
            polyval(pIntegralA, xIntegralA(a : b - 1)) - ...
            polyval(pIntegralA, xIntegralA(a));
        Summa = yIntegralA(b - 1) + ...
            polyval(pIntegralA, Ipoints(j)) - ...
            polyval(pIntegralA, xIntegralA(b - 1));
        j = j + 1;
        while Ipoints(j) <= xIntegralA(b)
            pIntegralA = GetIntegralPolynomialCoefficients...
                (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
            Summa = Summa + polyval(pIntegralA, Ipoints(j)) - ...
                polyval(pIntegralA, Ipoints(j - 1));
            j = j +1;
        end
        a = b;
        pIntegralA = GetIntegralPolynomialCoefficients...
            (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
        Summa = Summa + polyval(pIntegralA, xIntegralA(a)) - ...
            polyval(pIntegralA, Ipoints(j - 1));
    end
end

yIntegralA(a : end) = Summa + ...
    polyval(pIntegralA, xIntegralA(a : end)) - ...
    polyval(pIntegralA, xIntegralA(a));

end