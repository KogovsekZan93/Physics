function [yFitA, varargout] = ...
    ZFindFitA(xData, yData, xFitA, varargin)
%% Piecewise regression polynomial-based curve fitting 
%% tool with visualization
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
% the vector "yFitA" of the estimated values of f("xFitA"), where 
% "xFitA" is the input vector of values of the X variable. The 
% estimation is based on a piecewise regression polynomial of 
% the data points represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the f function along with the data points. 
% 
%% Variables
% 
% This function has the form of [yFitA, varargout] = ...
% ZFindFitA(xData, yData, xFitA, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xFitA" is the vector of the values of the independent variable 
% X at which the value of the f function is to be estimated. 
% The "xFitA" vector must be a column vector of real numbers. 
% The values of the "xFitA" vector must be in ascending order. 
% 
% "varargin" represents the optional input parameters 
% "PseudoAccuracy", "Mode", and "Figure". 
%     "PseudoAccuracy" is the name of the parameter the value 
%     of which is the order of the regression polynomials from 
%     which the piecewise regression polynomial which 
%     represents the f function is composed. It must be a 
%     nonnegative integer. The default value is "0". 
%     "Mode" is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise regression polynomial which 
%     represents the f function. It must be one of the three 
%     integers: "0", "1", "2". The default value is "0". 
%     "Figure" is the name of the parameter the value of which is 
%     the index of the figure on which the data points along with 
%     the estimation of the f function is to be plotted. The value of 
%     the "Figure" parameter can be any nonnegative integer. The 
%     default value is "0", at which no figure is to be plotted. 
% 
% "yFitA" is the column vector of the estimated values of 
% f("xFitA"). 
% 
% "varargout" represents the optional output parameter 
% "pFitA", which is the vector of coefficients of the 
% regression polynomial of the data points represented by the 
% pairs ("xData"(i), "yData"(i)). "pFitA" is a row vector of the 
% form of [a_("PolyDegree"), a_("PolyDegree" - 1), ..., a_(1), 
% a_(0)]. It can be evaluated by the MATLAB polyval function. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitA';
errorMsg = '''xFitA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitA);

[FigureParameter, vararginBasic] = ...
    SeparateAdditionalParameter(varargin, 'Figure');

[yFitA, Ipoints, Smatrix] = ZFindFitABasic...
    (xData, yData, xFitA, vararginBasic{:});

DrawZFitAHandle = @DrawZFitA;
DrawZFitAInput = {xData, yData, min(xData(1), xFitA(1)), ...
    max(xData(end), xFitA(end)), Ipoints, Smatrix};
DecideIfDrawZ...
    (DrawZFitAHandle, DrawZFitAInput, FigureParameter{:});

varargout = {Ipoints, Smatrix};

end