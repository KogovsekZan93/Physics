function [yIntegralA, varargout] = ZFindIntegralABasic...
    (xData, yData, xIntegralA, varargin)
%% Numerical piecewise interpolation polynomial-based indefinite 
%% integration tool
% 
% Author: �an Kogov�ek
% Date: 1.3.2023
% Last changed: 6.2.2023
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X and the 
% input vector 'yData' of the values of the dependent variable Y of an 
% arbitrary function Y = (df/dX)(X), this function returns the vector 
% 'yIntegralA' of the estimated values of 
% f('xIntegralA') - f('xIntegralA'(1)), where 'xIntegralA' is the input 
% vector of values of the X variable. The estimation is based on a 
% piecewise interpolation polynomial of the data points represented by the 
% pairs ('xData'(i), 'yData'(i)). 
% 
%% Variables
% 
% This function has the form of [yIntegralA, varargout] = ...
% ZFindIntegralABasic(xData, yData, xIntegralA, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the independent 
% variable X and of the dependent variable Y, respectively, of an 
% arbitrary function Y = (df/dX)(X) ('yData' = (df/dX)('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column vectors of 
% equal length and of real numbers. The values of the 'xData' vector must 
% be in ascending order. 
% 
% 'xIntegralA' is the vector of the values of the independent variable X 
% at which the values of the vector f('xIntegralA') - f('xIntegralA'(1)) 
% is to be estimated. The 'xIntegralA' vector must be a column vector of 
% real numbers. The values of the 'xIntegralA' vector must be in ascending 
% order. 
% 
% 'varargin' represents the optional input parameters named 
% ''PseudoAccuracy'' and ''Mode''. 
%    -''PseudoAccuracy'' is the name of the parameter the value 
%     of which is the order of the interpolation polynomials from 
%     which the piecewise interpolation polynomial which 
%     represents the df/dX function is composed. It must be a 
%     nonnegative integer. The default value is 0. 
%    -''Mode'' is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise interpolation polynomial which 
%     represents the df/dX function. It must be one of the three 
%     integers: 0, 1, or 2. The default value is 0. 
% 
% 'yIntegralA' is the column vector of the estimated values of 
% f('xIntegralA') - f('xIntegralA'(1)). 
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

paramName = 'PseudoAccuracy';
defaultVal = 0;
errorMsg = ...
    '''PseudoAccuracy'' must be a whole number, lower than length(''xData'').';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >= 0 && mod(x,1) == 0 && x < length(xData), errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Mode';
defaultVal = 1;
errorMsg = '''Mode'' must be either 0, 1, or 2.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, varargin{:});

PseudoAccuracy = pars.Results.PseudoAccuracy;
Mode = pars.Results.Mode;

[Ipoints, Smatrix] = GetIpointsSmatrix(xData, PseudoAccuracy + 1, Mode);
varargout = {Ipoints, Smatrix};

% In the following line, the EvaluateIpointsSmatrixIntegral 
% function is used to estimate the values of the 
% f('xIntegralA') - f('xIntegralA'(1)) vector by calculating the 
% definite integral of the piecewise interpolation polynomial 
% represented by the variables 'Ipoints' and 'Smatrix' from 
% 'xIntegralA'(1) to the each value of the 'xIntegralA' vector. 
yIntegralA = EvaluateIpointsSmatrixIntegral...
    (xData, yData, xIntegralA, Ipoints, Smatrix);

end