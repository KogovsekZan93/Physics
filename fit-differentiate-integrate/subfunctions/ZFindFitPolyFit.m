function [yFitPolyFit, varargout] = ZFindFitPolyFit...
    (xData, yData, xFitPolyFit, PolyDegree, varargin)
%% Polynomial regression-based curve fitting tool with 
%% visualization
% 
% Author: Žan Kogovšek
% Date: 9.11.2022
% Last changed: 9.11.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yFitPolyFit" of the estimated values of 
% f("xFitPolyFit"), where "xFitPolyFit" is the input vector of values 
% of the X variable. The estimation is based on the polynomial 
% regression interpolation of the data points represented by the 
% pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the f function along with the data points. 
% 
%% Variables
% 
% This function has the form of yFitSpline = ...
% ZFindFitSpline(xData, yData, xFitSpline, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xFitSpline" is the vector of the values of the independent 
% variable X at which the value of the f function is to be 
% estimated. The "xFitSpline" vector must be a column vector of 
% real numbers. 
% 
% "varargin" represents the optional input parameter "Figure". 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points along with the estimation of the 
% f function is to be plotted. The value of the "Figure" parameter 
% can be any nonnegative integer. The default value is "0", at 
% which no figure is to be plotted. 
% 
% "yFitSpline" is the column vector of the estimated values of 
% f("xFit"). 


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFit';
errorMsg = '''xFitPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitPolyFit);

[yFitPolyFit, pFitPolyFit] = ZFindFitPolyFitBasic(xData, yData, xFitPolyFit, PolyDegree);

DrawZFitPolyFitHandle = @DrawZFitPolyFit;
DrawZFitPolyFitInput = {xData, yData, min(xData(1), xFitPolyFit(1)), max(xData(end), xFitPolyFit(end)), pFitPolyFit};
DecideIfDrawZ(DrawZFitPolyFitHandle, DrawZFitPolyFitInput, varargin{:});

varargout = {pFitPolyFit};

end

