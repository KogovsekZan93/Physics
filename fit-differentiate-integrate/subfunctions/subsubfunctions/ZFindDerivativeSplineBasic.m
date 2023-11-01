function [yDerivativeSpline, varargout] = ...
    ZFindDerivativeSplineBasic...
    (xData, yData, xDerivativeSpline, varargin)
%% Numerical spline-based differentiation tool
% 
% Author: Žan Kogovšek
% Date: 11.26.2022
% Last changed: 11.1.2023
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X 
% and the input vector 'yData' of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector 'yDerivativeSpline' of the estimated values of 
% f^('OrdDeriv')('xDerivativeSpline'), where f^('OrdDeriv') is the 
% 'OrdDeriv'-th order derivative of the f function and 
% 'xDerivativeSpline' is the input vector of values of the X 
% variable. The estimation is based on the spline interpolation of 
% the data points represented by the pairs ('xData'(i), 'yData'(i)). 
% The optional parameter named ''OrdDeriv'' can be used to set 
% the order of differentiation, the default value of which is 
% 'OrdDeriv' = 1. 
% 
%% Variables
% 
% This function has the form of [yDerivativeSpline, varargout] = ...
% ZFindDerivativeSplineBasic...
% (xData, yData, xDerivativeSpline, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ('yData' = f('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. The values of the 
% 'xData' vector must be in ascending order. 
% 
% 'xDerivativeSpline' is the vector of the values of the 
% independent variable X at which the value of the derivative of 
% the f function is to be estimated. The 'xDerivativeSpline' vector 
% must be a column vector of real numbers. 
% 
% 'varargin' represents the optional input parameter named 
% ''OrdDeriv''. ''OrdDeriv'' is the name of the parameter the value 
% of which is the derivative order. It must be a natural number. 
% The default value is 1. 
% 
% 'yDerivativeSpline' is the column vector of the estimated 
% values of f^('OrdDeriv')('xDerivativeSpline'). 
% 
% 'varargout' represents the optional output parameters 
% 'ppDerivativeSpline' and 'ppFitSpline'.
%    -'ppDerivativeSpline' is the piecewise polynomial which is 
%     the estimation of the function f^('OrdDeriv'). It can be 
%     evaluated by the MATLAB ppval function. The details of the 
%    -'ppDerivativeSpline' piecewise polynomial can be 
%     extracted by the MATLAB unmkpp function. 
%    -'ppFitSpline' is the interpolating cubic spline of the data 
%     points represented by the pairs ('xData'(i), 'yData'(i)) which 
%     is the estimation of the f function. It can be evaluated by the 
%     MATLAB ppval function. The details of the 'ppFitSpline' 
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

OrdDeriv = pars.Results.OrdDeriv;

ppFitSpline = spline(xData, yData);
[Breaks, Coefs, ~, ~, ~] = unmkpp(ppFitSpline);

% In the following block of code, the coefficients of the 
% differentiated polynomials of the piecewise polynomial which 
% is the estimated f^('OrdDeriv') function are calculated. The 
% differentiated polynomials are appropriate derivatives of the 
% polynomials of which the cubic spline which interpolates the 
% data point is constructed. 
CoefsDeriv = Coefs;
if OrdDeriv < 4
    for i = 1 : OrdDeriv
        OrdPoly = length(CoefsDeriv(1, :)) - 1;
        CoefsDeriv = times(CoefsDeriv(:, 1 : OrdPoly), ...
            repmat((OrdPoly : -1 : 1), length(CoefsDeriv(:,1)), 1));
    end
else
     CoefsDeriv = zeros(length(CoefsDeriv(:,1)),1);
end

% In the following line, the piecewise polynomial which 
% represents the f^('OrdDeriv') function is constructed using the 
% MATLAB mkpp function. 
ppDerivativeSpline = mkpp(Breaks, CoefsDeriv);

varargout = {ppDerivativeSpline, ppFitSpline};

% Finally, the piecewise polynomial which is the estimation of the 
% f^('OrdDeriv') is evaluated for the values of the 
% 'xDerivativeSpline' vector of the X variable. 
yDerivativeSpline = ppval(ppDerivativeSpline, xDerivativeSpline);

end