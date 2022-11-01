function DefiniteIntegralPolyFit = ZFindDefiniteIntegralPolyFit...
    (xData, yData, Limits, PolyDegree, varargin)
%% Numerical polynomial regression-based definite 
%% integration tool with visualization
% 
% Author: Žan Kogovšek
% Date: 9.11.2022
% Last changed: 22.10.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the estimation "DefiniteIntegralPolyFit" of the definite 
% integral f("Limits"(2)) - f("Limits"(1)), where "Limits" is the input 
% vector of a pair of values of the X variable. The estimation is 
% based on the polynomial regression of the data points 
% represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from min("Limits") to max("Limits"), which is colored based on 
% the order of the pair of values of the "Limits" vector along with 
% the data points. 
% 
%% Variables
% 
% This function has the form of DefiniteIntegralPolyFit = ...
% ZFindDefiniteIntegralPolyFit...
% (xData, yData, Limits, PolyDegree, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX) ("xData")). 
% Both the “xData” vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "Limits" is the vector of the pair of values of the independent 
% variable X which represent the limits of integration of the df/dX 
% function. Thus, the function ZFindDefiniteIntegralPolyFit is to 
% estimate the value of f("Limits"(2)) - f("Limits"(1)). 
% The "Limits" vector must be a column vector of two real 
% numbers. 
% 
% “PolyDegree” is the degree of the regression polynomial of 
% the data points represented by the pairs ("xData"(i), "yData"(i)), 
% which is the estimation of the f function. The “PolyDegree” 
% degree must be a nonnegative integer. 
% 
% "varargin" represents the optional input parameter "Figure". 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points along with the estimation of the 
% df/dX function is to be plotted. Also, the area under the 
% estimated df/dX function curve is filled from min("Limits") to 
% max("Limits"). The color of the area is red if 
% "Limits"(1) > "Limits"(2) and blue if not. The value of the 
% "Figure" parameter can be any nonnegative integer. The 
% default value is "0", at which no figure is to be plotted. 
% 
% "DefiniteIntegralPolyFit" is the estimated value of the integral 
% of the df/dX function over the X variable with the lower limit 
% "Limits"(1) and the upper limit "Limits"(2). 


% The "ColorFace" parameter, obtained in the following line, 
% determines the color of the area under the estimated curve of 
% the df/dX function: red if "Limits"(1) > "Limits"(2) and blue if 
% not. 


[LimitsSorted, LimitOrder, ColorFace] = ...
    SortIntegrationLimits(Limits);

[yIndefiniteIntegralSpline, ppFitSpline] = ...
    ZFindIntegralPolyFitBasic...
    (xData, yData, LimitsSorted, PolyDegree);

DefiniteIntegralPolyFit = yIndefiniteIntegralSpline(2) * LimitOrder;

DrawZIntegralPolyFitHandle = @DrawZIntegralPolyFit;
DrawZIntegralPolyFitInput = {xData, yData, ...
    LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralPolyFitHandle, ...
    DrawZIntegralPolyFitInput, varargin{:});

end