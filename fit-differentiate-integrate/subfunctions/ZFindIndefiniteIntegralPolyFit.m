function yIndefiniteIntegralPolyFit = ...
    ZFindIndefiniteIntegralPolyFit...
    (xData, yData, xIntegralPolyFit, PolyDegree, varargin)
%% Numerical polynomial regression-based indefinite 
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
% returns the vector "yIndefiniteIntegralPolyFit" of the estimated 
% values of f("xIntegralPolyFit") - f("xIntegralPolyFit"(1)), where 
% "xIntegralPolyFit" is the input vector of values of the X 
% variable. The estimation is based on the polynomial 
% regression of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from "xIntegralPolyFit"(1) to "xIntegralPolyFit"(end) along with 
% the data points. 
% 
%% Variables
% 
% This function has the form of yIndefiniteIntegralPolyFit = ...
% ZFindIndefiniteIntegralPolyFit...
% (xData, yData, xIntegralPolyFit, PolyDegree, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX) ("xData")). 
% Both the “xData” vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xIntegralPolyFit" is the vector of the values of the 
% independent variable X at which the values of the vector 
% f("xIntegralPolyFit") - f("xIntegralPolyFit"(1)) is to be 
% estimated. 
% The "xIntegralPolyFit" vector must be a column vector of real 
% numbers. The values of the "xIntegralSpline" vector must be 
% in ascending order. 
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
% estimated df/dX function curve is filled from min("xIntegral"(1)) 
% to max("xIntegral"(2)). The value of the "Figure" parameter can 
% be any nonnegative integer. The default value is "0", at which 
% no figure is to be plotted. 
% 
% "yIndefiniteIntegralPolyFit" is the column vector of the 
% estimated values of 
% f("xIntegralSpline") - f("xIntegralSpline"(1)). 

pars = inputParser;

paramName = 'xIntegralPolyFit';
errorMsg = ...
    '''xIntegralPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralPolyFit);

[yIndefiniteIntegralPolyFit, pFitPolyFit] = ...
    ZFindIntegralPolyFitBasic...
    (xData, yData, xIntegralPolyFit, PolyDegree);

DrawZIntegralPolyFitHandle = @DrawZIntegralPolyFit;
ColorFace = [0, 0, 1];
DrawZIntegralPolyFitInput = {xData, yData, xIntegralPolyFit(1), ...
    xIntegralPolyFit(end), ColorFace, pFitPolyFit};
DecideIfDrawZ(DrawZIntegralPolyFitHandle, ...
    DrawZIntegralPolyFitInput, varargin{:});

end