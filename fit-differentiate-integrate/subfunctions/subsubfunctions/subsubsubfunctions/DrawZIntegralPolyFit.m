function DrawZIntegralPolyFit...
    (figr, xData, yData, xIntegralPolyFitMin, xIntegralPolyFitMax, ...
    ColorFace, pFitPolyFit)
%% Tool for plotting the data points, the regression
%% polynomial curve, and the area under the curve over 
%% an interval
% 
% Author: Žan Kogovšek
% Date: 3.19.2023
% Last changed: 3.19.2023
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
% area being defined by the RGB triplet of numbers of the 
% "ColorFace" vector. 
% 
%% Variables
% 
% This function has the form of DrawZIntegralPolyFit...
% (figr, xData, yData, xIntegralPolyFitMin, xIntegralPolyFitMax, ...
% ColorFace, pFitPolyFit)
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
% "ColoFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the interpolating spline curve of the 
% data points represented by the pairs ("xData"(i), "yData"(i)) 
% from the value "xIntegralSplineMin" to the 
% "xIntegralSplineMax" value. The three real numbers must be 
% values of the [0, 1] interval. 
% 
% "ppFitSpline" is the piecewise polynomial structure of the 
% spline polynomial fSpline of the data points represented by 
% the pairs ("xData"(i), "yData"(i)). 

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

paramName = 'xIntegralPolyFitMin';
errorMsg = '''xIntegralPolyFitMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralPolyFitMax';
errorMsg = ...
    '''xIntegralPolyFitMax'' must be a number which is greater than ''xIntegralPolyFitMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralPolyFitMax > xIntegralPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = ...
    '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'pFitPolyFit';
errorMsg = '''pFitPolyFit'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xIntegralPolyFitMin, ...
    xIntegralPolyFitMax, ColorFace, pFitPolyFit);

% The parameter "N" is set to be "N" = 1000 and represents the 
% number of points for both the regression polynomial curve and 
% the area under the regression polynomial curve. With this 
% setting, the number of points is typically sufficient to create a 
% convincing illusion of the plotted curve of the function fPolyFit 
% being smooth (as the actual fPolyFit function is, in fact, a 
% smooth function). 
N = 1000;

figure(figr)
clf;
hold on;

% In the following block of code, the area under the regression 
% polynomial curve is plotted. 
XFitPolyFit = (linspace...
    (xIntegralPolyFitMin, xIntegralPolyFitMax, N))';
YFitPolyFit = polyval(pFitPolyFit, XFitPolyFit);
h = area(XFitPolyFit, YFitPolyFit);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

% In the following block of code, the regression polynomial 
% curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)) is plotted. 
xFitPolyFit = (linspace(min(xData(1), xIntegralPolyFitMin), ...
    max(xData(end), xIntegralPolyFitMax), N))';
yFitPolyFit = polyval(pFitPolyFit, xFitPolyFit);
plot(xFitPolyFit, yFitPolyFit, 'r', 'LineWidth', 1.2);

% Lastly, in the following line, the data points themselves are 
% plotted. 
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end