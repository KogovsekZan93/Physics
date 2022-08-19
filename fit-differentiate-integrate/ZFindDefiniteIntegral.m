function DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, varargin)
%% Numerical definite integration tool
% 
% Author: Žan Kogovšek
% Date: 8.14.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the estimation "yIndefiniteIntegral" of the definite 
% integral f("Limits"(2)) - f("Limits"(1)) where "Limits" is the input 
% vector of a pair of values of the X variable. 
% By setting the optional parameters, the user can: 
%       (1) choose from various methods of the estimation, some 
%       of which offer additional optional parameters and output 
%       variables or need additional required parameters, 
%       (2) plot the estimated curve of the df/dX function and the 
%       area under it from min("Limits") to max("Limits") based on 
%       the order of the pair of values of the "Limits" vector along 
%       with the data points represented by the pairs 
%       ("xData"(i), "yData"(i)). 
% 
%% Variables
% 
% This function has the form of DefiniteIntegral = ...
% ZFindDefiniteIntegral(xData, yData, Limits, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX) ("xData")). 
% Both the “xData” vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must in ascending order. 
% 
% "Limits" is the vector of the pair of values of the independent 
% variable X which represent the limits of integration of the df/dX 
% function. Thus, the function ZFindDefiniteIntegral is to 
% estimate the value of f("Limits"(2)) - f("Limits"(1)). 
%  The “Limits” vector must be a column vector of two real 
% numbers. 
% 
% “varargin” represents optional parameters. The basic optional 
% parameters are “Type” and “Figure”. 
%     "Type" is a parameter which determines the mathematical 
%     method with which the df/dX function is estimated. The 
%     value of the "Type" parameter can either be "'A'", "'Spline'", 
%     or "'PolyFit'". The default value is "'A'". The value of the 
%     "Type" parameter determines the set of additional required 
%     or optional parameters. 
%     "Figure" is a parameter, the value of which is the index of 
%     the figure on which the data points along with the estimation 
%     of the f function is to be plotted. Also, the area under the 
%     estimated f function curve is filled from min("Limits"(1)) to 
%     max("Limits"(2)). The color of the area is blue if 
%     "Limits"(2) > "Limits"(1) and red if not. The value of the 
%     "Figure" parameter can be any nonnegative integer. The 
%     default value is “0”, at which no figure is to be plotted. 


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
    DefiniteIntegral = ZFindDefiniteIntegralA(xData, yData, Limits, TypeDeletedList{:});
else
    if strcmp(type, 'Spline')
        DefiniteIntegral = ZFindDefiniteIntegralSpline(xData, yData, Limits, TypeDeletedList{:});
    else
        DefiniteIntegral = ZFindDefiniteIntegralPolyFit(xData, yData, Limits, TypeDeletedList{:});
    end
end

end