function DefiniteIntegralSpline = ZFindDefiniteIntegralSpline...
    (xData, yData, Limits, varargin)
%% Numerical spline-based definite integration tool  
%% with visualization
% 
% Author: Žan Kogovšek
% Date: 8.23.2022
% Last changed: 2.5.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the estimation "DefiniteIntegralSpline" of the definite 
% integral f("Limits"(2)) - f("Limits"(1)), where "Limits" is the input 
% vector of a pair of values of the X variable. The estimation is 
% based on the spline interpolation of the data points 
% represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from min("Limits") to max("Limits"), which is colored based on 
% the order of the pair of values of the "Limits" vector along with 
% the data points. 
% 
%% Variables
% 
% This function has the form of DefiniteIntegralSpline = ...
% ZFindDefiniteIntegralSpline(xData, yData, Limits, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX)("xData")). 
% Both the “xData” vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "Limits" is the vector of the pair of values of the independent 
% variable X which represent the limits of integration of the df/dX 
% function. Thus, the function ZFindDefiniteIntegralSpline is to 
% estimate the value of f("Limits"(2)) - f("Limits"(1)). The "Limits" 
% vector must be a column vector of two real numbers. 
% 
% "varargin" represents the optional input parameter "Figure". 
% "Figure" is the name of the parameter the value of which is the 
% index of the figure on which the data points along with the 
% estimation of the df/dX function is to be plotted. Also, the area 
% under the estimated df/dX function curve is filled from 
% min("Limits") to max("Limits"). The color of the area is red if 
% "Limits"(1) > "Limits"(2) and blue if not. The value of the 
% "Figure" parameter can be any nonnegative integer. The 
% default value is "0", at which no figure is to be plotted. 
% 
% "DefiniteIntegralSpline" is the estimated value of the integral 
% of the df/dX function over the X variable with the lower limit 
% "Limits"(1) and the upper limit "Limits"(2). 


% The "ColorFace" parameter, obtained in the following line, 
% determines the color of the area under the estimated curve of 
% the df/dX function: red if "Limits"(1) > "Limits"(2) and blue if 
% not. 
[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits...
    (Limits);

[yIntegralSpline, ppFitSpline] = ZFindIntegralSplineBasic...
    (xData, yData, LimitsSorted);

% In the following line, the estimated definite integral 
% "DefiniteIntegralSpline" is calculated by multiplying the 
% "yIntegralSpline"(2) value by either "1" or "-1" based on the 
% order of the limits on integration. 
DefiniteIntegralSpline = yIntegralSpline(2) * LimitOrder;

% The following block of code deals with plotting the estimated 
% curve of the df/dX function and the area under it from 
% min("Limits") to max("Limits") along with the data points. 
DrawZIntegralSplineHandle = @DrawZIntegralSpline;
DrawZIntegralSplineInput = {xData, yData, ...
    LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, ...
    DrawZIntegralSplineInput, varargin{:});

end