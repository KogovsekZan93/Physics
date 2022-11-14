function yDerivativeA = ...
    ZFindDerivativeA(xData, yData, xDerivativeA, varargin)
%% Numerical piecewise regression polynomial-based 
%% differentiation tool with visualization
% 
% Author: Žan Kogovšek
% Date: 11.12.2022
% Last changed: 11.14.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yDerivativeA" of the estimated values of 
% f^("OrdDeriv")("xDerivativeA"), where f^("OrdDeriv") is the 
% "OrdDeriv"-th order derivative of the f function and 
% "xDerivativeA" is the input vector of values of the X variable. 
% The estimation is based on a piecewise regression 
% polynomial of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). 
% The optional parameter "OrdDeriv" can be used to set the 
% order of differentiation, the default value of which is 
% "OrdDeriv" == 1. 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the f function along with the data points. 
% 
%% Variables
% 
% This function has the form of yDerivativeA = ...
% ZFindDerivativeA(xData, yData, xDerivativeA, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xDerivativeA" is the vector of the values of the independent 
% variable X at which the value of the derivative of the f function 
% is to be estimated. 
% The "xDerivativeA" vector must be a column vector of real 
% numbers. The values of the "xDerivativeA" vector must be in 
% ascending order. 
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
% "yDerivativeA" is the column vector of the estimated 
% values of f^("OrdDeriv")("xDerivativeA"). 
% 
% "varargout" represents the optional output parameter 
% "pDerivativeA", which is the vector of coefficients of the 
% "OrdDeriv"-th derivative of the regression polynomial of the 
% data points represented by the pairs ("xData"(i), "yData"(i)). 
% "pFitA" is a row vector of the form of 
% [a_("PolyDegree" - "OrdDeriv"), 
% a_("PolyDegree" - "OrdDeriv" - 1), ..., a_(1), a_(0)]. It can be 
% evaluated by the MATLAB polyval function. 


[FigureParameter, NonFigureParameters] = ...
    SeparateAdditionalParameter(varargin, 'Figure');

pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativeA';
errorMsg = ...
    '''xDerivativeA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xDerivativeA);

[yDerivativeA, Ipoints, Smatrix] = ZFindDerivativeABasic...
    (xData, yData, xDerivativeA, NonFigureParameters{:});

DrawZFitAHandle = @DrawZFitA;
DrawZFitAInput = {xData, yData, ...
    min(xDerivativeA(1), xData(1)), max(xDerivativeA(end), ...
    xData(end)), Ipoints, Smatrix};
DecideIfDrawZ(DrawZFitAHandle, DrawZFitAInput, ...
    FigureParameter{:});

end