function [yFitPolyFit, varargout] = ZFindFitPolyFit...
    (xData, yData, xFitPolyFit, PolyDegree, varargin)
%% Polynomial regression-based curve fitting tool with 
%% visualization
% 
% Author: Žan Kogovšek
% Date: 9.11.2022
% Last changed: 11.9.2022
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
% This function has the form of [yFitPolyFit, varargout] = ...
% ZFindFitPolyFit...
% (xData, yData, xFitPolyFit, PolyDegree, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xFitPolyFit" is the vector of the values of the independent 
% variable X at which the value of the f function is to be 
% estimated. The "xFitPolyFit" vector must be a column vector 
% of real numbers. 
% 
% "PolyDegree" is the degree of the regression polynomial of 
% the data points represented by the pairs ("xData"(i), "yData"(i)), 
% which is the estimation of the f function. The "PolyDegree" 
% degree must be a nonnegative integer. 
% 
% "varargin" represents the optional input parameter "Figure". 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points along with the estimation of the 
% f function is to be plotted. The value of the "Figure" parameter 
% can be any nonnegative integer. The default value is "0", at 
% which no figure is to be plotted. 
% 
% "yFitPolyFit" is the column vector of the estimated values of 
% f("xFitPolyFit"). 
% 
% "varargout" represents the optional output parameter 
% "pFitPolyFit", which is the vector of coefficients of the 
% regression polynomial of the data points represented by the 
% pairs ("xData"(i), "yData"(i)). "pFitPolyFit" is a row vector of the 
% form of [a_("PolyDegree"), a_("PolyDegree" - 1), ..., a_(1), 
% a_(0)]. It can be evaluated by the MATLAB polyval function. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFit';
errorMsg = ...
    '''xFitPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitPolyFit);

[yFitPolyFit, pFitPolyFit] = ZFindFitPolyFitBasic...
    (xData, yData, xFitPolyFit, PolyDegree);

% The following block of code deals with plotting the estimated 
% curve of the f function along with the data points. 

DrawZFitPolyFitHandle = @DrawZFitPolyFit;
DrawZFitPolyFitInput = {xData, yData, ...
    min(xData(1), xFitPolyFit(1)), ...
    max(xData(end), xFitPolyFit(end)), pFitPolyFit};
DecideIfDrawZ...
    (DrawZFitPolyFitHandle, DrawZFitPolyFitInput, varargin{:});

varargout = {pFitPolyFit};

end