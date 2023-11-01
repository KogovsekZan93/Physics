function [yFitA, varargout] = ZFindFitABasic...
    (xData, yData, xFitA, varargin)
%% Piecewise interpolation polynomial-based curve fitting 
%% tool
% 
% Author: Žan Kogovšek
% Date: 1.3.2023
% Last changed: 11.1.2023
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
% 
%% Variables
% 
% This function has the form of [yFitA, varargout] = ...
% ZFindFitABasic(xData, yData, xFitA, varargin)
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
% 'xFitA' vector must be a column vector of real numbers. The 
% values of the 'xFitA' vector must be in ascending order. 
% 
% 'varargin' represents the optional input parameters named
% ''PseudoAccuracy'' and ''Mode''. 
%    -''PseudoAccuracy'' is the name of the parameter the value 
%     of which is the order of the interpolation polynomials from 
%     which the piecewise interpolation polynomial which 
%     represents the f function is to be composed. It must be a 
%     nonnegative integer. The default value is 0. 
%    -''Mode'' is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise interpolation polynomial which 
%     represents the f function. It must be one of the three 
%     integers: 0, 1, or 2. The default value is 0. 
% 
% 'yFitA' is the column vector of the estimated values of 
% f('xFitA'). 
% 
% 'varargout' represents the optional output parameters 
% 'Ipoints' and 'Smatrix'. 
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

paramName = 'PseudoAccuracy';
defaultVal = 1;
errorMsg = ...
    '''PseudoAccuracy'' must be a nonnegative integer which is lower than length(''xData'').';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 0 && mod(x,1) == 0 && x < length(xData), errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Mode';
defaultVal = 1;
errorMsg = '''Mode'' must be either 0, 1, or 2.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, varargin{:});

PseudoAccuracy = pars.Results.PseudoAccuracy;
Mode = pars.Results.Mode;

[Ipoints, Smatrix] = GetIpointsSmatrix...
    (xData, PseudoAccuracy + 1, Mode);

yFitA = EvaluateIpointsSmatrixFit...
    (xData, yData, xFitA, Ipoints, Smatrix);

varargout = {Ipoints, Smatrix};

end