function [yDerivativePolyFit, varargout] = ...
    ZFindDerivativePolyFitBasic...
    (xData, yData, xDerivativePolyFit, PolyDegree, varargin)
%% Numerical polynomial regression-based differentiation 
%% tool
% 
% Author: Žan Kogovšek
% Date: 1.1.2023
% Last changed: 10.21.2023
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
% 
%% Variables
% 
% This function has the form of [yDerivativePolyFit, ...
% varargout] = ZFindDerivativePolyFitBasic...
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
% "varargin" represents the optional input parameter "OrdDeriv". 
% "OrdDeriv" is the name of the parameter the value of which is 
% the derivative order. It must be a natural number. The default 
% value is "1". 
% 
% "yDerivativePolyFit" is the column vector of the estimated 
% values of f^("OrdDeriv")("xDerivativePolyFit"). 
% 
% "varargout" represents the optional output parameters. The 
% optional parameters are "pDerivativePolyFit" and "pFitPolyFit". 
%    -"pDerivativePolyFit" is the vector of coefficients of the 
%     polynomial which is the "OrdDeriv"-th derivative of the 
%     "PolyDegree"-th degree regression polynomial of the data 
%     points represented by the pairs ("xData"(i), "yData"(i)). 
%     "pDerivativePolyFit" is a column vector of the form of 
%     [a_("PolyDegree" - "OrdDeriv"); 
%     a_("PolyDegree" - "OrdDeriv" - 1); ..., a_1; a_0]. The 
%     differentiated regression polynomial can be evaluated by 
%     the MATLAB polyval function. 
%    -"pFitPolyFit" is the vector of coefficients of the 
%     "PolyDegree"-th degree regression polynomial of the data 
%     points represented by the pairs ("xData"(i), "yData"(i)). 
%     "pFitPolyFit" is a column vector of the form of 
%     [a_"PolyDegree"; a_("PolyDegree" - 1); ...; a_1; a_0]. The 
%     regression polynomial can be evaluated by the MATLAB 
%     polyval function. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xDerivativePolyFit';
errorMsg = '''xDerivativePolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'PolyDegree';
errorMsg = '''PolyDegree'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >=0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, yData, xDerivativePolyFit, PolyDegree, ...
    varargin{:});

OrdDeriv = pars.Results.OrdDeriv;

% In the following two lines, in the first line, the regression 
% polynomial coefficients of the data points which are 
% represented by the pairs ("xData"(i). "yData"(i)) are calculated. 
% In the second line, the coefficients of the polynomial which is 
% the derivative of the regression polynomial are calculated. 
pFitPolyFit = (polyfit(xData, yData, PolyDegree))';
pDerivativePolyFit = ...
    CalculateDerivativePolynomialCoefficients...
    (pFitPolyFit, OrdDeriv);

yDerivativePolyFit = polyval...
    (pDerivativePolyFit, xDerivativePolyFit);
varargout = {pDerivativePolyFit, pFitPolyFit};

end