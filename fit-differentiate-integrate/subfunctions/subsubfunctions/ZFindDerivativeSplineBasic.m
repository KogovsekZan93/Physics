function [yDerivativeSpline, varargout] = ...
    ZFindDerivativeSplineBasic...
    (xData, yData, xDerivativeSpline, varargin)
%% Numerical spline-based differentiation tool
% 
% Author: �an Kogov�ek
% Date: 11.26.2022
% Last changed: 11.26.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yDerivativeSpline" of the estimated values of 
% f^("OrdDeriv")("xDerivativeSpline"), where f^("OrdDeriv") is the 
% "OrdDeriv"-th order derivative of the f function and 
% "xDerivativeSpline" is the input vector of values of the X 
% variable. The estimation is based on the spline interpolation of 
% the data points represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "OrdDeriv" can be used to set the 
% order of differentiation, the default value of which is 
% "OrdDeriv" == 1. 
% 
%% Variables
% 
% This function has the form of [yDerivativeSpline, varargout] = ...
% ZFindDerivativeSplineBasic...
% (xData, yData, xDerivativeSpline, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xDerivativeSpline" is the vector of the values of the 
% independent variable X at which the value of the derivative of 
% the f function is to be estimated. The "xDerivativeSpline" 
% vector must be a column vector of real numbers. 
% 
% "varargin" represents the optional input parameter "OrdDeriv". 
% "OrdDeriv" is the name of the parameter the value of which is 
% the derivative order. It must be a natural number. The default 
% value is "1". 
% 
% "yDerivativeSpline" is the column vector of the estimated 
% values of f^("OrdDeriv")("xDerivativeSpline"). 
% 
% "varargout" represents the optional output parameters 
% "ppDerivativeSpline" and "ppFitSpline".
%     "ppDerivativeSpline" is the piecewise polynomial which is 
%     the estimation of the function f^("OrdDeriv"). It can be 
%     evaluated by the MATLAB ppval function. The details of the 
%     "ppDerivativeSpline" piecewise polynomial can be 
%     extracted by the MATLAB unmkpp function. 
%     "ppFitSpline" is the cubic spline of the data points 
%     represented by the pairs ("xData"(i), "yData"(i)) which is the 
%     estimation of the f function. It can be evaluated by the 
%     MATLAB ppval function. The details of the " ppFitSpline" 
%     piecewise polynomial can be extracted by the MATLAB 
%     unmkpp function. 


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

paramName = 'xDerivativeSpline';
errorMsg = ...
    '''xDerivativeSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, yData, xDerivativeSpline, varargin{:});

ordDeriv = pars.Results.OrdDeriv;

pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppFitSpline = mkpp(breaks, coefs);

coefsDeriv = coefs;

if ordDeriv < 4
    for i = 1 : ordDeriv
        ordPoly = length(coefsDeriv(1, :)) - 1;
        coefsDeriv = times(coefsDeriv(:, 1 : ordPoly), ...
            repmat((ordPoly : -1 : 1), length(coefsDeriv(:,1)), 1));
    end
else
     coefsDeriv = zeros(length(coefsDeriv(:,1)),1);
end

ppDerivativeSpline = mkpp(breaks, coefsDeriv);
varargout = {ppDerivativeSpline, ppFitSpline};

yDerivativeSpline = ppval(ppDerivativeSpline, xDerivativeSpline);

end