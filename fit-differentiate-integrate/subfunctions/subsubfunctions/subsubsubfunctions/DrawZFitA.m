function DrawZFitA...
    (figr, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix)
%% Tool for plotting the data points and the piecewise 
%% interpolation polynomial curve
% 
% Author: Žan Kogovšek
% Date: 22.4.2023
% Last changed: 4.22.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the vector 
% "Ipoints" and the matrix "Smatrix", both of which define the 
% fA piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), and the natural 
% number "figr", this function plots the data points and the 
% piecewise interpolation polynomial curve of the data points 
% from the input value of the X variable "xFitAMin" to the input 
% value of the X variable "xFitAMax". 
% 
%% Variables
% 
% This function has the form of DrawZFitA...
% (figr, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix)

pars = inputParser;

paramName = 'figr';
errorMsg = '''figr'' must be a natural number.';
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
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
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

parse...
    (pars, figr, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix);

N = power(10, 4);

xFitA = (linspace(xFitAMin, xFitAMax, N))';
yFitA = EvaluateIpointsSmatrixFit...
    (xData, yData, xFitA, Ipoints, Smatrix);

figure(figr);

plot(xFitA, yFitA, 'r', 'LineWidth', 1.2);
hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

% The following lines contain the code for plotting the 
% approximation of the f function either if len_Ipoints ~= 2 or if 
% len_Ipoints == 2 (in the case of which the approximation of the 
% function is the Lagrange polynomial of all (x(i), y(i)) pairs). 

end