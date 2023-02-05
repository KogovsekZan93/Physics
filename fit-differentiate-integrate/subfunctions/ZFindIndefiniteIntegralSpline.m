function yIndefiniteIntegralSpline = ...
    ZFindIndefiniteIntegralSpline...
    (xData, yData, xIntegralSpline, varargin)
%% Numerical spline-based indefinite integration tool with 
%% visualization
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
% returns the vector "yIndefiniteIntegralSpline" of the estimated 
% values of f("xIntegralSpline") - f("xIntegralSpline"(1)), where 
% "xIntegralSpline" is the input vector of values of the X variable. 
% The estimation is based on the spline interpolation of the data 
% points represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from "xIntegralSpline"(1) to "xIntegralSpline"(end) along with 
% the data points. 
% 
%% Variables
% 
% This function has the form of yIndefiniteIntegralSpline = ...
% ZFindIndefiniteIntegralSpline...
% (xData, yData, xIntegralSpline, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX)("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xIntegralSpline" is the vector of the values of the independent 
% variable X at which the values of the vector 
% f("xIntegralSpline") - f("xIntegralSpline"(1)) is to be estimated. 
% The "xIntegralSpline" vector must be a column vector of real 
% numbers. The values of the "xIntegralSpline" vector must be 
% in ascending order. 
% 
% "varargin" represents the optional input parameter "Figure". 
% "Figure" is the name of the parameter the value of which is the 
% index of the figure on which the data points along with the 
% estimation of the df/dX function is to be plotted. Also, the area 
% under the estimated df/dX function curve is filled from 
% min("xIntegralSpline"(1)) to max("xIntegralSpline"(2)). The 
% value of the "Figure" parameter can be any nonnegative 
% integer. The default value is "0", at which no figure is to be 
% plotted. 
% 
% "yIndefiniteIntegralSpline" is the column vector of the 
% estimated values of 
% f("xIntegralSpline") - f("xIntegralSpline"(1)). 


pars = inputParser;

paramName = 'xIntegralSpline';
errorMsg = ...
    '''xIntegralSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralSpline);

[yIndefiniteIntegralSpline, ppFitSpline] = ...
    ZFindIntegralSplineBasic(xData, yData, xIntegralSpline);

% The following block of code deals with plotting the estimated 
% curve of the df/dX function and the area under it from 
% "xIntegralSpline"(1) to "xIntegralSpline"(end) along with the 
% data points. 
DrawZIntegralSplineHandle = @DrawZIntegralSpline;
ColorFace = [0, 0, 1];
DrawZIntegralSplineInput = {xData, yData, xIntegralSpline(1), ...
    xIntegralSpline(end), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, ...
    DrawZIntegralSplineInput, varargin{:});

end