function DrawZIntegralSpline...
    (figr, xData, yData, xIntegralSplineMin, xIntegralSplineMax, ...
    ColorFace, ppFitSpline)
%% Tool for plotting the data points, the interpolating 
%% spline, and the area under the curve over an interval
% 
% Author: Žan Kogovšek
% Date: 3.18.2023
% Last changed: 3.18.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the 
% piecewise polynomial structure "ppFitSpline" of the spline 
% polynomial fSpline of the data points represented by the pairs 
% ("xData"(i), "yData"(i)), the values of the X variable the 
% "xIntegralSplineMin" value and the "xIntegralSplineMax" value, 
% the natural number "figr", and the vector "ColorFace", this 
% function plots the data points, the spline curve of the data 
% points and the area under the spline curve from 
% "xIntegralSplineMin" to "xIntegralSplineMax", the color of the 
% area being defined by the RGB triplet of numbers in the 
% "ColorFace" vector. 
% 
%% Variables
% 
% This function has the form of DrawZIntegralSpline...
% (figr, xData, yData, xIntegralSplineMin, xIntegralSplineMax, ...
% ColorFace, ppFitSpline)
% 
% "figr" is the parameter the value of which is the index of the 
% figure on which the data points, the spline curve, and the area 
% under the curve described in the Description section is to be 
% plotted. The value of the "figr" parameter must be a natural 
% number. 
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% The "xIntegralSplineMin" parameter and the 
% "xIntegralSplineMax" parameter are two values of the X 
% variable and are the lower and the upper boundary, 
% respectively, of the area to be plotted using this function under 
% the cubic spline curve of the data points represented by the 
% pairs ("xData"(i), "yData"(i)). The "xIntegralSplineMax" value 
% must be greater than the "xIntegralSplineMin" value. 
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

paramName = 'xIntegralMin';
errorMsg = '''xIntegralMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralMax';
errorMsg = ...
    '''xIntegralMax'' must be a number which is greater than ''xIntegralMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralSplineMax > xIntegralSplineMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = ...
    '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ppFitSpline';
errorMsg = '''ppFitSpline'' must be a structure array.';
validationFcn = @(x)assert(isstruct(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xIntegralSplineMin, ...
    xIntegralSplineMax, ColorFace, ppFitSpline);

N = 1000;

figure(figr)
clf;
hold on;

XFitSpline = (linspace...
    (xIntegralSplineMin, xIntegralSplineMax, N))';
YFitSpline = ppval(ppFitSpline, XFitSpline);
h = area(XFitSpline, YFitSpline);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

xFitSpline = (linspace(min(min(xData), xIntegralSplineMin), ...
    max(max(xData), xIntegralSplineMax), N))';
yFitSpline = ppval(ppFitSpline, xFitSpline);
plot(xFitSpline, yFitSpline, 'r', 'LineWidth', 1.2);

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end