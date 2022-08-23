function [yDerivativeSpline, varargout] = ZFindDerivativeSpline(xData, yData, xDerivativeSpline, varargin)
%% Numerical spline-based differentiation tool with 
%% visualization
% 
% Author: Žan Kogovšek
% Date: 8.23.2022
% Last changed: 8.23.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yDerivative" of the estimated values of 
% f^("OrdDeriv")(" xDerivative"), where f^("OrdDeriv") is the 
% "OrdDeriv"-th order derivative of the f function and 
% "xDerivative" is the input vector of values of the X variable. 
% The estimation is based on the spline interpolation of the data 
% points represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "OrdDeriv" can be used to set the 
% order of differentiation, the default value of which is 
% "OrdDeriv" == 1. 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the f function along with the data points. 


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