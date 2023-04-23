function DrawZIntegralA...
    (figr, xData, yData, xIntegralAMin, xIntegralAMax, ...
    ColorFace, Ipoints, Smatrix)
%% Tool for plotting the data points, the piecewise 
%% interpolation polynomial curve, and the area under the 
%% curve over an interval
% 
% Author: Žan Kogovšek
% Date: 3.24.2023
% Last changed: 4.23.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the vector 
% "Ipoints" and the matrix "Smatrix", both of which define the 
% fA piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), the values of 
% the X variable the "xIntegralAMin" value and the 
% "xIntegralAMax" value, the natural number "figr", and the 
% vector "ColorFace", this function plots the data points, the 
% piecewise interpolation polynomial curve of the data points, 
% and the area under the piecewise interpolation polynomial 
% curve from "xIntegralAMin" to "xIntegralAMax", the color of the 
% area being defined by the RGB triplet of numbers of the 
% "ColorFace" vector. 
% 
%% Variables
% 
% This function has the form of DrawZIntegralA
% (figr, xData, yData, xIntegralAMin, xIntegralAMax, ColorFace, ...
% Ipoints, Smatrix)
% 
% "figr" is the parameter the value of which is the index of the 
% figure on which the data points, the piecewise interpolation 
% polynomial curve, and the area under the curve described in 
% the Description section is to be plotted. The value of the "figr" 
% parameter must be a natural number. 
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% The "xIntegralAMin" parameter and the "xIntegralAMax" 
% parameter are two values of the X variable and are the lower 
% and the upper boundary, respectively, of the area to be plotted 
% using this function under the piecewise interpolation 
% polynomial curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). The "xIntegralAMax" value must be 
% greater than the "xIntegralAMin" value. 
% 
% "ColorFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the piecewise interpolation polynomial 
% curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)) from the value "xIntegralAMin" to the 
% "xIntegralAMax" value. The three real numbers must be values 
% of the [0, 1] interval. 
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

paramName = 'xIntegralAMin';
errorMsg = '''xIntegralAMin'' must be a number.';
validationFcn = @(x)assert...
    (isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralAMax';
errorMsg = ...
    '''xIntegralAMax'' must be a number which is greater than ''xIntegralAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralAMax > xIntegralAMin, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, xIntegralAMin, xIntegralAMax);

figure(figr)

% In the following block of code, the area under the piecewise 
% interpolation polynomial curve is plotted. 
DrawZAreaA(xData, yData, xIntegralAMin, xIntegralAMax, ...
    ColorFace, Ipoints, Smatrix)

hold on;

% In the following block of code, the piecewise interpolation 
% polynomial curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)) as well as the data points themselves 
% are plotted. 
DrawZFitA(figr, xData, yData, min(xData(1), xIntegralAMin), ...
    max(xData(end), xIntegralAMax), Ipoints, Smatrix)

end