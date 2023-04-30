function DrawZIntegralSpline...
    (figr, xData, yData, xIntegralSplineMin, xIntegralSplineMax, ...
    ColorFace, ppFitSpline)
%% Tool for plotting the data points, the interpolating 
%% spline curve, and the area under the curve over an 
%% interval
% 
% Author: Žan Kogovšek
% Date: 3.18.2023
% Last changed: 4.30.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the 
% piecewise polynomial structure "ppFitSpline" of the 
% interpolating cubic spline polynomial fSpline of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), the values of 
% the X variable the "xIntegralSplineMin" value and the 
% "xIntegralSplineMax" value, the natural number "figr", and the 
% vector "ColorFace", this function plots the data points, the 
% spline curve of the data points, and the area under the spline 
% curve from "xIntegralSplineMin" to "xIntegralSplineMax", the 
% color of the area being defined by the RGB triplet of numbers 
% of the "ColorFace" vector. 
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
% the interpolating spline curve of the data points represented 
% by the pairs ("xData"(i), "yData"(i)). The "xIntegralSplineMax" 
% value must be greater than the "xIntegralSplineMin" value. 
% 
% "ColorFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the interpolating spline curve of the 
% data points represented by the pairs ("xData"(i), "yData"(i)) 
% from the value "xIntegralSplineMin" to the 
% "xIntegralSplineMax" value. The three real numbers must be 
% values of the [0, 1] interval. 
% 
% "ppFitSpline" is the piecewise polynomial structure of the 
% interpolating cubic spline polynomial fSpline of the data points 
% represented by the pairs ("xData"(i), "yData"(i)). 


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

paramName = 'xIntegralSplineMin';
errorMsg = '''xIntegralSplineMin'' must be a number.';
validationFcn = ...
    @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralSplineMax';
errorMsg = ...
    '''xIntegralSplineMax'' must be a number which is greater than ''xIntegralSplineMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralSplineMax > xIntegralSplineMin, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, xIntegralSplineMin, xIntegralSplineMax);

figure(figr);

% In the following block of code, the area under the interpolating 
% spline curve is plotted. 
DrawZAreaSpline(xIntegralSplineMin, xIntegralSplineMax, ...
    ColorFace, ppFitSpline)

hold on;

% In the following block of code, the interpolating spline curve of 
% the data points represented by the pairs ("xData"(i), "yData"(i)) 
% as well as the data points themselves are plotted. 
DrawZFitSpline(figr, xData, yData, ...
    min(xData(1), xIntegralSplineMin), ...
    max(xData(end), xIntegralSplineMax), ppFitSpline)

end