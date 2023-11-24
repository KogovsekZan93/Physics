function [yFitA, varargout] = ZFindFitA...
    (xData, yData, xFitA, varargin)
%% Piecewise interpolation polynomial-based curve fitting 
%% tool with visualization
% 
% Author: Žan Kogovšek
% Date: 11.12.2022
% Last changed: 11.24.2023
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X 
% and the input vector 'yData' of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector 'yFitA' of the estimated values of f('xFitA'), where 
% 'xFitA' is the input vector of values of the X variable. The 
% estimation is based on a piecewise interpolation polynomial of 
% the data points represented by the pairs ('xData'(i), 'yData'(i)). 
% The optional parameter named ''Figure'' can be used to plot 
% the estimated curve of the f function along with the data points. 
% 
%% Variables
% 
% This function has the form of [yFitA, varargout] = ...
% ZFindFitA(xData, yData, xFitA, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ('yData' = f('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. The values of the 
% 'xData' vector must be in ascending order. 
% 
% 'xFitA' is the vector of the values of the independent variable 
% X at which the value of the f function is to be estimated. The 
% 'xFitA' vector must be a column vector of real numbers. 
% The values of the 'xFitA' vector must be in ascending order. 
% 
% 'varargin' represents the optional input parameters named 
% ''PseudoAccuracy'', ''Mode'', and ''Figure''. 
%    -''PseudoAccuracy'' is the name of the parameter the value 
%     of which is the order of the interpolation polynomials from 
%     which the piecewise interpolation polynomial which 
%     represents the f function is composed. It must be a 
%     nonnegative integer. The default value is 0. 
%    -''Mode'' is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise interpolation polynomial which 
%     represents the f function. It must be one of the three 
%     integers: 0, 1, or 2. The default value is 0. 
%    -''Figure'' is the name of the parameter the value of which is 
%     the index of the figure window on which the data points 
%     along with the estimation of the f function is to be plotted. 
%     The value of the 'Figure' parameter can be any nonnegative 
%     integer. The default value is 0, at which no figure is to be 
%     plotted. 
% 
% 'yFitA' is the column vector of the estimated values of 
% f('xFitA'). 
% 
% 'varargout' represents the optional output parameters 'Ipoints' 
% and 'Smatrix'. 
%    -'Ipoints' is a column vector of boundaries between the 
%     interpolation polynomials of the piecewise interpolation 
%     polynomial which is the estimation of the f function. Any two 
%     consecutive values of the 'Ipoints' vector 'Ipoints'(i) and 
%     'Ipoints'(i + 1) are the boundaries of i-th interpolation 
%     polynomial. 
%    -'Smatrix' is the matrix of rows of indices. Each row 
%     'Smatrix'(i, :) contains the indeces k of the data points 
%     ('xData'(k), 'yData'(k)) which were used to construct the i-th 
%     interpolation polynomial of the piecewise interpolation 
%     polynomial which is the estimation of the f function. 
%     The piecewise polynomial which is used to estimate the f 
%     function can be evaluated by using the parameters 'Ipoints' 
%     and 'Smatrix' as the input of the EvaluateIpointsSmatrixFit 
%     function. 


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

% The following block of code deals with plotting the estimated 
% f function curve along with the data points. 
DrawZFitAHandle = @DrawZFitA;
DrawZFitAInput = {xData, yData, min(xData(1), xFitA(1)), ...
    max(xData(end), xFitA(end)), Ipoints, Smatrix};
DecideIfDrawZ...
    (DrawZFitAHandle, DrawZFitAInput, FigureParameter{:});

varargout = {Ipoints, Smatrix};

end