function DrawZFitSpline(Figure, xData, yData, ...
    xFitSplineMin, xFitSplineMax, ppFitSpline)
%% Tool for plotting the data points and the interpolating 
%% spline curve
% 
% Author: Žan Kogovšek
% Date: 4.22.2023
% Last changed: 10.21.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), the piecewise 
% polynomial structure "ppFitSpline" of the interpolating cubic 
% spline polynomial fSpline of the data points represented by 
% the pairs ("xData"(i), "yData"(i)), and the natural number 
% "Figure", this function plots the data points and the spline 
% curve of the data points from the input value of the X variable 
% "xFitSplineMin" to the input value of the X variable 
% "xFitSplineMax". 
% 
%% Variables
% 
% This function has the form of DrawZFitSpline(Figure, ...
% xData, yData, xFitSplineMin, xFitSplineMax, ppFitSpline)
% 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points and the spline curve described 
% in the Description section is to be plotted. The value of the 
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
% The "xFitSplineMin" parameter and the "xFitSplineMax" 
% parameter are two values of the X variable and are the lower 
% and the upper boundary, respectively, of the interval over 
% which the cubic spline curve of the data points represented by 
% the pairs ("xData"(i), "yData"(i)) is to be plotted. The 
% "xFitSplineMax" value must be greater than the "xFitSplineMin" 
% value. 
% 
% "ppFitSpline" is the piecewise polynomial structure of the 
% interpolating cubic spline polynomial fSpline of the data points 
% represented by the pairs ("xData"(i), "yData"(i)). 


pars = inputParser;

paramName = 'Figure';
errorMsg = '''Figure'' must be a natural number.';
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

paramName = 'xFitSplineMin';
errorMsg = '''xFitSplineMin'' must be a number.';
validationFcn = ...
    @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitSplineMax';
errorMsg = ...
    '''xFitSplineMax'' must be a number which is greater than ''xFitSplineMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitSplineMax > xFitSplineMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ppFitSpline';
errorMsg = '''ppFitSpline'' must be a structure array.';
validationFcn = @(x)assert(isstruct(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, Figure, xData, yData, xFitSplineMin, xFitSplineMax, ...
    ppFitSpline);

% The parameter "N" is set to be "N" = 10 000 and represents 
% the number of points for the interpolating spline curve plot. 
% With this setting, the number of points is typically sufficient to 
% create a convincing illusion of the plotted curve of the function 
% fSpline being smooth (as the actual fSpline function is, in fact, 
% a smooth function). 
N = power(10, 4);

xFitSpline = (linspace(xFitSplineMin, xFitSplineMax, N))';
yFitSpline = ppval(ppFitSpline, xFitSpline);

figure(Figure);

plot(xFitSpline, yFitSpline, 'r', 'LineWidth', 1.2);
hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end