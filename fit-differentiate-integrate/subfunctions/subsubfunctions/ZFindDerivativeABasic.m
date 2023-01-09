function [yDerivativeA, varargout] = ZFindDerivativeABasic...
    (xData, yData, xDerivativeA, varargin)
%% Numerical piecewise regression polynomial-based 
%% differentiation tool
% 
% Author: Žan Kogovšek
% Date: 1.3.2023
% Last changed: 1.9.2023
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
% 
%% Variables
% 
% This function has the form of [yDerivativeA, varargout] = ...
% ZFindDerivativeABasic(xData, yData, xDerivativeA, varargin)
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
% "OrdDeriv", "Accuracy" and "Mode". 
%     "OrdDeriv" is the parameter the value of which is the 
%     derivative order. It must be a natural number. The default 
%     value is "1". 
%     "Accuracy" is the name of the parameter the value of which 
%     is the order of the regression polynomials from which the 
%     piecewise regression polynomial which represents the f 
%     function is composed. It must be a nonnegative integer. 
%     The default value is "0". 
%     "Mode" is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise regression polynomial which 
%     represents the f function. It must be one of the three 
%     integers: "0", "1", "2". The default value is "0". 
% 
% "yDerivativeA" is the column vector of the estimated values of 
% f^("OrdDeriv")("xDerivativeA"). 
% 
% "varargout" represents the optional output parameters 
% "Ipoints" and "Smatrix". 
%     "Ipoints" is a column vector of boundaries between the 
%     regression polynomials of the piecewise regression 
%     polynomial which is the estimation of the f function. Any two 
%     consecutive values of the "Ipoints"(i : i + 1) vector are the 
%     boundaries of i-th regression polynomial. 
%     "Smatrix" is the matrix of rows of indices. Each row 
%     "Smatrix"(i, :) contains the indeces k of the data points 
%     ("xData"(k), "yData"(k)) which were used to construct the i-th 
%     regressional polynomial of the piecewise regression 
%     polynomial which is the estimation of the f function. 
%     The piecewise polynomial which is used to estimate the f 
%     function can be evaluated by using the parameters "Ipoints" 
%     and "Smatrix" as the input of the EvaluateIpointsSmatrixFit 
%     function. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Accuracy';
defaultVal = 2;
errorMsg = '''Accuracy'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

paramName = 'Mode';
defaultVal = 1;
errorMsg = '''Mode'' must be either ''0'', ''1'', or ''2''.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn)

parse(pars, xData, varargin{:});

ordDeriv = pars.Results.OrdDeriv;
acc = pars.Results.Accuracy;
mode = pars.Results.Mode;

nA = acc + ordDeriv;

if nA > length(xData)
    error(...
        '''Accuracy + OrdDeriv'' must be equal to or lower than ''length(xData)''.');
end

[Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode);
varargout = {Ipoints, Smatrix};

% In the following line, the EvaluateIpointsSmatrixDerivative 
% function is used to estimate the values of the 
% f^("OrdDeriv")("xDerivativeA") vector by calculating the 
% derivative of the piecewise regression polynomial represented 
% by the variables "Ipoints" and "Smatrix" for the values of the 
% "xDerivativeA" vector. 
yDerivativeA = EvaluateIpointsSmatrixDerivative...
    (xData, yData, xDerivativeA, ordDeriv, Ipoints, Smatrix);

end