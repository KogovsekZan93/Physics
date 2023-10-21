function DrawZFitA...
    (Figure, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix)
%% Tool for plotting the data points and the piecewise 
%% interpolation polynomial curve
% 
% Author: Žan Kogovšek
% Date: 4.22.2023
% Last changed: 10.21.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the vector 
% "Ipoints" and the matrix "Smatrix", both of which define the fA 
% piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), and the natural 
% number "Figure", this function plots the data points and the 
% piecewise interpolation polynomial curve of the data points 
% from the input value of the X variable "xFitAMin" to the input 
% value of the X variable "xFitAMax". 
% 
%% Variables
% 
% This function has the form of DrawZFitA...
% (Figure, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix)
% 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points, the piecewise interpolation 
% polynomial curve, and the area under the curve described in 
% the Description section is to be plotted. The value of the 
% "Figure" parameter must be a natural number. 
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% The "xFitAMin" parameter and the "xFitAMax" parameter are 
% two values of the X variable and are the lower and the upper 
% boundary, respectively, of the interval over which the 
% piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)) is to be 
% plotted. The "xFitAMax" value must be greater than the 
% "xFitAMin" value. 
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
% height of which is length("Ipoints") - 1. 


pars = inputParser;

paramName = 'Figure';
errorMsg = '''Figure'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitAMin';
errorMsg = '''xFitAMin'' must be a number.';
validationFcn = ...
    @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitAMax';
errorMsg = ...
    '''xFitAMax'' must be a number which is greater than ''xFitAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitAMax > xFitAMin, errorMsg);
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

parse(pars, Figure, xData, yData, xFitAMin, xFitAMax, ...
    Ipoints, Smatrix);

% The parameter "N" is set to be "N" = 10 000 and represents 
% the number of points for the piecewise interpolation 
% polynomial curve plot. With this setting, the number of points 
% is typically sufficient to create a convincing illusion of the 
% plotted curve of the function fA being smooth over the 
% intervals over which the fA function is, in fact, smooth. 
N = power(10, 4);

xFitA = (linspace(xFitAMin, xFitAMax, N))';
yFitA = EvaluateIpointsSmatrixFit...
    (xData, yData, xFitA, Ipoints, Smatrix);

figure(Figure);

plot(xFitA, yFitA, 'r', 'LineWidth', 1.2);
hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end