function [yDerivativeSpline, varargout] = ZFindDerivativeSpline(xData, yData, xDerivativeSpline, varargin)
%% Numerical spline-based differentiation tool with 
%% visualization
% 
% Author: Žan Kogovšek
% Date: 8.23.2022
% Last changed: 9.4.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yDerivative" of the estimated values of 
% f^("OrdDeriv")("xDerivativeSpline"), where f^("OrdDeriv") is the 
% "OrdDeriv"-th order derivative of the f function and 
% "xDerivativeSpline" is the input vector of values of the X 
% variable. The estimation is based on the spline interpolation of 
% the data points represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "OrdDeriv" can be used to set the 
% order of differentiation, the default value of which is 
% "OrdDeriv" == 1. 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the f function along with the data points. 
% 
%% Variables
% 
% This function has the form of [yDerivativeSpline, varargout] = ...
% ZFindDerivativeSpline...
% (xData, yData, xDerivativeSpline, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xDerivativeSpline" is the vector of the values of the 
% independent variable X at which the value of the derivative of 
% the f function is to be estimated. The "xDerivativeSpline" 
% vector must be a column vector of real numbers. 
% 
% "varargin" represents the optional input parameters. The basic 
% optional parameters are "OrdDeriv" and "Figure". 
%     "OrdDeriv" is the parameter the value of which is the 
%     derivative order. The default value is "1". 
%     "Figure" is the parameter the value of which is the index of 
%     the figure on which the data points along with the estimation 
%     of the f function is to be plotted. The value of the "Figure" 
%     parameter can be any nonnegative integer. The default 
%     value is "0", at which no figure is to be plotted. 
% 
% "yDerivativeSpline" is the column vector of the estimated 
% values of f^("OrdDeriv")(" xDerivativeSpline"). 
% 
% "varargout" represents the optional output parameter 
% "ppDerivativeSpline", which is the piecewise polynomial which 
% represents the function f^("OrdDeriv"). It can be evaluated by 
% the MATLAB ppval function. The details of the 
% "ppDerivativeSpline" piecewise polynomial can be extracted 
% by the MATLAB unmkpp function. 


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativeSpline';
errorMsg = '''xDerivative'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Figure';
defaultVal = 0;
errorMsg = '''Figure'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 0 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, xDerivativeSpline, varargin{:});

ordDeriv = pars.Results.OrdDeriv;
figr = pars.Results.Figure;


[yDerivativeSpline, ppDerivativeSpline, ppFitSpline] = ZFindDerivativeSplineBasic(xData, yData, xDerivativeSpline, 'OrdDeriv', ordDeriv);
varargout = {ppDerivativeSpline};

DrawZFitSplineHandle = @DrawZFitSpline;
DrawZFitSplineInput = {xData, yData, min(xDerivativeSpline(1), xData(1)), max(xDerivativeSpline(end), xData(end)), ppFitSpline};
DecideIfDrawZ(DrawZFitSplineHandle, DrawZFitSplineInput, 'Figure', figr);

end