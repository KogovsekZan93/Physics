function [yDerivative, varargout] = ZFindDerivative(xData, yData, xDerivative, varargin)
%% Numerical differentiation tool
% 
% Author: Žan Kogovšek
% Date: 8.10.2022
% 
%% Description
% 
% Given the input vector “xData” of the independent variable X 
% and the input vector “yData” of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yDerivative" of the estimated values of 
% f^(“OrdDeriv”)(“ xDerivative”) where f^(“OrdDeriv”) is the 
% “OrdDeriv“-th order derivative of the f function and 
% “xDerivative” is the input vector of values of the X variable. 
% By setting the optional parameters, the user can: 
%       (1) set the order of differentiation, the default value of 
%       which is “OrdDeriv“ == 1, 
%       (2) choose from various methods of the estimation, some 
%       of which offer additional optional parameters and output 
%       variables or need additional required parameters, 
%       (3) plot the estimated curve of the f function along with the 
%       data points represented by the pairs (“xData”(i), “yData”(i)). 
% 
%% Variables
% 
% This function has the form of [yDerivative, varargout] = ...
% ZFindDerivative(xData, yData, xDerivative, varargin)
% 
% “xData” and “yData” are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% (“yData” = f(“xData”)). 
% Both the “xData” vector and the “yData” vector must be 
% column vectors of equal length and of real numbers. The 
% values of the “xData” vector must in ascending order. 
% 
% “xDerivative” is the vector of the values of the independent 
% variable X at which the value of the derivative of the f function 
% is to be estimated. The “xDerivative” vector must be a column 
% vector of real numbers. 
% 
% 

[TypeList, TypeDeletedList] = SeparateOptionalParameter(varargin, 'Type');

pars = inputParser;

paramName = 'Type';
defaultVal = 'A';
errorMsg = '''Type'' must be either "A", "Spline", or "PolyFit".';
validationFcn = @(x)assert(strcmp(x, 'A') || strcmp(x, 'Spline') ...
    || strcmp(x, 'PolyFit') , errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, TypeList{:});

type = pars.Results.Type;

if strcmp(type, 'A')
    yDerivative = ZFindDerivativeA(xData, yData, xDerivative, TypeDeletedList{:});
    varargout = {};
else
    if strcmp(type, 'Spline')
        [yDerivative, ppDerivativeSpline] = ZFindDerivativeSpline(xData, yData, xDerivative, TypeDeletedList{:});
        varargout = {ppDerivativeSpline};
    else
        [yDerivative, pDerivativePolyFit] = ZFindDerivativePolyFit(xData, yData, xDerivative, TypeDeletedList{:});
        varargout = {pDerivativePolyFit};
    end
end

end