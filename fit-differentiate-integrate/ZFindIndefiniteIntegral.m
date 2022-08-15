function yIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, xIntegral, varargin)
%% Numerical indefinite integration tool
% 
% Author: Žan Kogovšek
% Date: 8.14.2022
% 
%% Description
% 
% Given the input vector “xData” of the independent variable X 
% and the input vector “yData” of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the vector “yIndefiniteIntegral" of the estimated values 
% of f(“xIntegral”) - f(“xIntegral”(1)) where “xIntegral” is the input 
% vector of values of the X variable. 
% By setting the optional parameters, the user can: 
%       (1) choose from various methods of the estimation, some 
%       of which offer additional optional parameters and output 
%       variables or need additional required parameters, 
%       (2) plot the estimated curve of the df/dX function and the 
%       area under it from “xIntegral”(1) to “xIntegral”(end) to along 
%       with the data points represented by the pairs 
%       (“xData”(i), “yData”(i)). 
% 
%% Variables
% 
% This function has the form of yIndefiniteIntegral = ...
% ZFindIndefiniteIntegral(xData, yData, xIntegral, varargin)
% 
% “xData” and “yData” are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% (“yData” = (df/dX) (“xData”)). 
% Both the “xData” vector and the “yData” vector must be 
% column vectors of equal length and of real numbers. The 
% values of the “xData” vector must in ascending order. 
% 
% “xIntegral” is the vector of the values of the independent 
% variable X at which the values of the vector 
% f(“xIntegral”) - f(“xIntegral”(1)) is to be estimated. The 
% “xDerivative” vector must be a column vector of real numbers. 





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
    yIndefiniteIntegral = ZFindIndefiniteIntegralA(xData, yData, xIntegral, TypeDeletedList{:});
else
    if strcmp(type, 'Spline')
        yIndefiniteIntegral = ZFindIndefiniteIntegralSpline(xData, yData, xIntegral, TypeDeletedList{:});
    else
        yIndefiniteIntegral = ZFindIndefiniteIntegralPolyFit(xData, yData, xIntegral, TypeDeletedList{:});
    end
end

end