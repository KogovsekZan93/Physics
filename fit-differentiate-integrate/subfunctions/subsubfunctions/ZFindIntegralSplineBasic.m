function [yIntegralSpline, varargout] = ZFindIntegralSplineBasic...
    (xData, yData, xIntegralSpline)
%% Numerical spline-based indefinite integration tool
% 
% Author: Žan Kogovšek
% Date: 11.26.2022
% Last changed: 12.24.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the vector "yIntegralSpline" of the estimated values of 
% f("xIntegralSpline") - f("xIntegralSpline"(1)), where 
% "xIntegralSpline" is the input vector of values of the X variable. 
% The estimation is based on the spline interpolation of the data 
% points represented by the pairs ("xData"(i), "yData"(i)). 
% 
%% Variables
% 
% This function has the form of [yIntegralSpline, varargout] = ...
% ZFindIntegralSplineBasic(xData, yData, xIntegralSpline)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX) ("xData")). 
% Both the “xData” vector and the “yData” vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xIntegralSpline" is the vector of the values of the independent 
% variable X at which the values of the vector 
% f("xIntegralSpline") - f("xIntegralSpline"(1)) is to be estimated. 
% The "xIntegralSpline" vector must be a column vector of real 
% numbers. The values of the "xIntegralSpline" vector must be 
% in ascending order. 
% 
% "yIntegralSpline" is the column vector of the estimated values 
% of f("xIntegralSpline") - f("xIntegralSpline"(1)). 
% 
% "varargout" represents the optional output parameter 
% "ppFitSpline", which is the cubic spline of the data points 
% represented by the pairs ("xData"(i), "yData"(i)) which is the 
% estimation of the function df/dX. It can be evaluated by the 
% MATLAB ppval function. The details of the " ppFitSpline" 
% piecewise polynomial can be extracted by the MATLAB 
% unmkpp function. 


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

paramName = 'xIntegralSpline';
errorMsg = ...
    '''xIntegralSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xIntegralSpline);

pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppFitSpline = mkpp(breaks, coefs);
coefsLength = length(coefs);

% In the following line, the coefficeints of an integral of each 
% polynomial of the piecewise polynomial which represents the 
% spline function S, which represent the function df/dX, are 
% calculated. "coefsInteg" is the matrix of ordered rows of 
% coefficients of these integrated polynomials. 
coefsInteg = ...
    [times(coefs, repmat([1/4, 1/3, 1/2, 1], coefsLength, 1)), ...
    zeros(coefsLength,1)];

% In the following block of code, the boundaries of the 
% integrated polynomials p_i are defined as a horizontal vector 
% of consecutive borders. 
breaksReal = breaks;
breaksReal(1) = - inf; 
breaksReal(end) = inf;

xIntegralSplineLength = length(xIntegralSpline);
yIntegralSpline = zeros(xIntegralSplineLength, 1);

% The following while loop is used to find p_("j" - 1), which is the 
% first integrated polynomial p_i which is to be used to evaluate 
% the "yIntegralSpline" vector. 
j = 2;
while breaksReal(j) <= xIntegralSpline(1)
    j = j +1;
end

% In the following line, the piecewise polynomial P is defined as 
% a MATLAB object. The piecewise polynomial P is constructed 
% of the integrated polynomials p_i from p_("j" - 1) onwards with 
% the boundaries which are represented by the vector of 
% consecutive boundaries "breaksReal"("j" - 1, :). The "breaks" 
% vector is used for its definition in the actual function because 
% the MATLAB function mkpp does not return proper values if 
% there are infinities in the required mkpp parameter "breaks". 
ppIntegralSpline = mkpp...
    ([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));

% The parameter summa will be used to track the value of the 
% estimation of the definite integral of the df/dX function from 
% "xIntegralSpline"(1) to both boundaries of the piecewise 
% polynomial P and values of "xIntegralSpline". 
Summa = 0;
a = 1;

for b = 2 : xIntegralSplineLength
    if xIntegralSpline(b) >= breaksReal(j)
        yIntegralSpline(a : b - 1) = Summa + ...
            ppval(ppIntegralSpline, xIntegralSpline(a : b - 1)) - ...
            ppval(ppIntegralSpline, xIntegralSpline(a));
        Summa = yIntegralSpline(b - 1) + ...
            ppval(ppIntegralSpline, breaks(j)) - ...
            ppval(ppIntegralSpline, xIntegralSpline(b - 1));
        j = j + 1;
        while breaksReal(j) <= xIntegralSpline(b)
            ppIntegralSpline = mkpp...
                ([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));
            Summa = Summa + ppval(ppIntegralSpline, breaks(j)) - ...
                ppval(ppIntegralSpline, breaks(j - 1));
            j = j +1;
        end
        a = b;
        ppIntegralSpline = mkpp...
            ([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));
    end
end

yIntegralSpline(a : end) = Summa + ppval...
    (ppIntegralSpline, xIntegralSpline(a : end)) - ppval...
    (ppIntegralSpline, max(breaks(j - 1), ...
    xIntegralSpline(max(a - 1, 1))));

varargout = {ppFitSpline};

end