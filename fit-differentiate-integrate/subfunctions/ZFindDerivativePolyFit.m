function [yDerivativePolyFit, varargout] = ZFindDerivativePolyFit...
    (xData, yData, xDerivativePolyFit, PolyDegree, varargin)
%% Numerical polynomial regression-based differentiation 
%% tool with visualization
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
% the vector "yDerivativePolyFit" of the estimated values of 
% f^("OrdDeriv")("xDerivativePolyFit"), where f^("OrdDeriv") is 
% the "OrdDeriv"-th order derivative of the f function and 
% "xDerivativePolyFit" is the input vector of values of the X 
% variable. The estimation is based on the polynomial 
% regression of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). 
% The optional parameter "OrdDeriv" can be used to set the 
% order of differentiation, the default value of which is 
% "OrdDeriv" == 1. 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the f function along with the data points. 
% 
%% Variables
% 
% This function has the form of [yDerivativePolyFit, varargout] ...
% = ZFindDerivativePolyFit...
% (xData, yData, xDerivativePolyFit, PolyDegree, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xDerivativePolyFit" is the vector of the values of the 
% independent variable X at which the value of the derivative of 
% the f function is to be estimated. The "xDerivativePolyFit" 
% vector must be a column vector of real numbers. 
% 
% "PolyDegree" is the degree of the regression polynomial of 
% the data points represented by the pairs ("xData"(i), "yData"(i)), 
% which is the estimation of the f function. The "PolyDegree" 
% degree must be a nonnegative integer. 
% 
% "varargin" represents the optional input parameters. The 
% optional parameters are "OrdDeriv" and "Figure". 
%     "OrdDeriv" is the name of the parameter the value of which 
%     is the derivative order. It must be a natural number. The 
%     default value is "1". 
%     "Figure" is the name of the parameter the value of which is 
%     the index of the figure on which the data points along with 
%     the estimation of the f function is to be plotted. The value of 
%     the "Figure" parameter can be any nonnegative integer. The 
%     default value is "0", at which no figure is to be plotted. 
% 
% "yDerivativePolyFit" is the column vector of the estimated 
% values of f^("OrdDeriv")("xDerivativePolyFit"). 
% 
% "varargout" represents the optional output parameter 
% "pDerivativePolyFit", which is the vector of coefficients of the 
% "OrdDeriv"-th derivative of the regression polynomial of the 
% data points represented by the pairs ("xData"(i), "yData"(i)). 
% "pFitPolyFit" is a row vector of the form of 
% [a_("PolyDegree" - "OrdDeriv"), 
% a_("PolyDegree" - "OrdDeriv" - 1), ..., a_(1), a_(0)]. It can be 
% evaluated by the MATLAB polyval function. 


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativePolyFit';
errorMsg = ...
    '''xDerivativePolyFit'' must be a sorted column vector of numbers.';
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

parse(pars, xData, xDerivativePolyFit, varargin{:});

ordDeriv = pars.Results.OrdDeriv;
figr = pars.Results.Figure;

[yDerivativePolyFit, pDerivativePolyFit, pFitPolyFit] = ...
    ZFindDerivativePolyFitBasic...
    (xData, yData, xDerivativePolyFit, PolyDegree, ...
    'OrdDeriv', ordDeriv);
varargout = {pDerivativePolyFit};

% The following block of code deals with plotting the estimated 
% curve of the f function along with the data points. 

DrawZFitPolyFitHandle = @DrawZFitPolyFit;
DrawZFitPolyFitInput = {xData, yData, ...
    min(xData(1), xDerivativePolyFit(1)), ...
    max(xData(end), xDerivativePolyFit(end)), pFitPolyFit};
DecideIfDrawZ...
    (DrawZFitPolyFitHandle, DrawZFitPolyFitInput, 'Figure', figr);

end