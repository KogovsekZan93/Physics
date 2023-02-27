function yFitA = EvaluateIpointsSmatrixFit...
    (xData, yData, xFitA, Ipoints, Smatrix)
%% Tool for evaluating the piecewise interpolation 
%% polynomial
% 
% Author: Žan Kogovšek
% Date: 2.27.2023
% Last changed: 2.27.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yFitA", which is the vector of values fA("xFitA") 
% where fA is the the "Ipoints" vector- and the "Smatrix" matrix-
% defined piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), and "xFitA" is 
% the input vector of values of the X variable. 
% 
%% Variables
% 
% This function has the form of yFitA = ...
% EvaluateIpointsSmatrixFit(xData, yData, xFitA, Ipoints, Smatrix)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xFitA" is the vector of the values of the independent variable 
% X at which the value of the piecewise interpolation polynomial 
% fA is to be calculated. The fA function is a piecewise 
% interpolation polynomial of the data points represented by the 
% pairs ("xData"(i), "yData"(i)) and is defined by the input 
% variables the "Ipoints" vector and the "Smatrix" matrix. Each 
% polynomial p_i of which the fA function consists is the 
% interpolation polynomial of the points 
% ("xData"("Smatrix"(i, :)), "yData"("Smatrix"(i, :))) and is defined 
% over the interval from "Ipoints"(i) to "Ipoints"(i + 1). The "xFitA" 
% vector must be a column vector of real numbers. The values 
% of the "xFitA" vector must be in ascending order. 
% 
% "Ipoints" is a column vector of boundaries between the 
% interpolation polynomials of the piecewise interpolation 
% polynomial fA. Any two consecutive values of the "Ipoints" 
% vector "Ipoints"(i) and "Ipoints"(i + 1) are the boundaries of i-th 
% interpolation polynomial. It must be a sorted column vector of 
% numbers. 
% 
% "Smatrix" is the matrix of rows of indices. Each row 
% "Smatrix"(i, :) contains the indeces k of the data points 
% ("xData"(k), "yData"(k)) which were used to construct the i-th 
% interpolation polynomial p_i of the piecewise interpolation
% polynomial fA. It must be a matrix of natural numbers the 
% hight of which is length("Ipoints") - 1. 
% 
% "yFitA" is the column vector of the calculated values of 
% fA("xFitA"). 


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

paramName = 'xFitA';
errorMsg = '''xFitA'' must be a sorted column vector of numbers.';
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

parse(pars, xData, yData, xFitA, Ipoints, Smatrix);

j = 2;
a = 1;

xFitALength = length(xFitA);
yFitA = zeros(xFitALength, 1);

while Ipoints(j) <= xFitA(1)
    j = j +1;
end

p = GetFitPolynomialCoefficients...
    (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

for b = 2 : xFitALength
    if xFitA(b) >= Ipoints(j)
        yFitA(a : b - 1) = polyval(p, xFitA(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xFitA(b)
            j = j +1;
        end
        a = b;
        p = GetFitPolynomialCoefficients...
            (xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yFitA(a : end) = polyval(p, xFitA(a : end));

end