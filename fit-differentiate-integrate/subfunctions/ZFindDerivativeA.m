function yDerivativeA = ZFindDerivativeA...
    (xData, yData, xDerivativeA, varargin)
%% Numerical piecewise interpolation polynomial-based 
%% differentiation tool with visualization
% 
% Author: Žan Kogovšek
% Date: 11.12.2022
% Last changed: 4.30.2023
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
% The estimation is based on a piecewise interpolation 
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
% "varargin" represents the optional input parameters 
% "OrdDeriv", "Accuracy", "Mode", and "Figure". 
%    -"OrdDeriv" is the name of the parameter the value of which 
%     is the derivative order. It must be a natural number. The 
%     default value is "1". 
%    -"Accuracy" is the name of the parameter the value of which 
%     is the order of the interpolation polynomials from which the 
%     piecewise interpolation polynomial which represents the f 
%     function is composed. It must be a nonnegative integer. 
%     The default value is "0". 
%    -"Mode" is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise interpolation polynomial which 
%     represents the f function. It must be one of the three 
%     integers: "0", "1", "2". The default value is "0". 
%    -"Figure" is the name of the parameter the value of which is 
%     the index of the figure on which the data points along with 
%     the estimation of the f function is to be plotted. The value of 
%     the "Figure" parameter can be any nonnegative integer. The 
%     default value is "0", at which no figure is to be plotted. 
% 
% "yDerivativeA" is the column vector of the estimated values of 
% f^("OrdDeriv")("xDerivativeA"). 


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

% The following block of code deals with plotting the estimated 
% curve of the f function along with the data points. 
DrawZFitAHandle = @DrawZFitA;
DrawZFitAInput = {xData, yData, ...
    min(xDerivativeA(1), xData(1)), max(xDerivativeA(end), ...
    xData(end)), Ipoints, Smatrix};
DecideIfDrawZ(DrawZFitAHandle, DrawZFitAInput, ...
    FigureParameter{:});

end