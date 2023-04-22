function DrawZFitPolyFit...
    (figr, xData, yData, xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit)
%% Tool for plotting the data points and the regression
%% polynomial curve
% 
% Author: Žan Kogovšek
% Date: 22.4.2023
% Last changed: 4.22.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), the vector 
% "pFitPolyFit" of the coefficients of the regression polynomial 
% fPolyFit of the data points represented by the pairs 
% ("xData"(i), "yData"(i)), and the natural number "figr, this 
% function plots the data points and the regression polynomial 
% curve of the data points from the input value of the X variable 
% "xFitPolyFitMin" to the input value of the X variable 
% "xFitSplineMax". 
% 
%% Variables
% 
% This function has the form of DrawZFitPolyFit...
% (figr, xData, yData, xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit)

pars = inputParser;

paramName = 'figr';
errorMsg = '''figr'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

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

paramName = 'xFitPolyFitMin';
errorMsg = '''xFitSplineMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFitMax';
errorMsg = ...
    '''xFitSplineMax'' must be a number which is greater than ''xFitSplineMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitPolyFitMax > xFitPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'pFitPolyFit';
errorMsg = '''pFitPolyFit'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xFitPolyFitMin, xFitPolyFitMax, ...
    pFitPolyFit);

N = power(10, 4);

xFitPolyFit = (linspace(xFitPolyFitMin, xFitPolyFitMax, N))';
yFitPolyFit = polyval(pFitPolyFit, xFitPolyFit);

figure(figr);

plot(xFitPolyFit, yFitPolyFit, 'r', 'LineWidth', 1.2);
hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end