function [yFit, varargout] = ZFindFit(xData, yData, xFit, varargin)
%% Curve fitting tool
% 
% Author: Žan Kogovšek
% Date: 8.10.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector “yData” of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yFit" of the estimated values of f("xFit") where 
% "xFit" is the input vector of values of the X variable. 
% By setting the optional parameters, the user can: 
%       (1) choose from various methods of the estimation, some 
%       of which offer additional optional parameters and output 
%       variables or need additional required parameters, 
%       (2) plot the estimated curve of the f function along with the 
%       data points represented by the pairs ("xData"(i), "yData"(i)). 
% 
%% Variables
% 
% This function has the form of [yFit, varargout] = ...
% ZFindFit(xData, yData, xFit, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the “xData” vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must in ascending order. 
% 
% "xFit" is the vector of the values of the independent variable X 
% at which the value of the f function is to be estimated. The 
% "xFit" vector must be a column vector of real numbers. 
% 
% "varargin" represents the additional input parameters. The 
% basic optional parameters are "Type" and "Figure". 
%     "Type" is the parameter which determines the mathematical 
%     method with which the f function is estimated. The value of 
%     the "Type" parameter can either be "'A'", "'Spline'", or 
%     "'PolyFit'". The default value is "'A'". The value of the "Type" 
%     parameter determines the set of the optional output 
%     parameters and additional required or optional input 
%     parameters. 
%     "Figure" is the parameter the value of which is the index of 
%     the figure on which the data points along with the estimation 
%     of the f function is to be plotted. The value of the “Figure” 
%     parameter can be any nonnegative integer. The default 
%     value is "0", at which no figure is to be plotted. 
% 
% "yFit" is the column vector of the estimated values of f("xFit"). 
% 
% "varargout" represents the optional output parameters. The 
% set of the optional parameters depends on the value of the 
% "Type" optional input parameter. 


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
    [yFit, Ipoints, Smatrix] = ZFindFitA(xData, yData, xFit, TypeDeletedList{:});
    varargout = {Ipoints, Smatrix};
else
    if strcmp(type, 'Spline')
        yFit = ZFindFitSpline(xData, yData, xFit, TypeDeletedList{:});
    else
        [yFit, pFitPolyFit] = ZFindFitPolyFit(xData, yData, xFit, TypeDeletedList{:});
        varargout = {pFitPolyFit};
    end
end

end