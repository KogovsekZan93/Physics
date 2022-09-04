function yFitSpline = ZFindFitSpline(xData, yData, xFitSpline, varargin)
%% Spline curve fitting tool with visualization
% 
% Author: Žan Kogovšek
% Date: 8.23.2022
% Last changed: 9.4.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector "yFitSpline" of the estimated values of 
% f("xFitSpline"), where "xFitSpline " is the input vector of values 
% of the X variable. The estimation is based on the spline 
% interpolation of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). The optional parameter "Figure" can be 
% used to plot the estimated curve of the f function along with 
% the data points. 
% 
%% Variables
% 
% This function has the form of yFitSpline = ...
% ZFindFitSpline(xData, yData, xFitSpline, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xFitSpline" is the vector of the values of the independent 
% variable X at which the value of the f function is to be 
% estimated. The "xFitSpline" vector must be a column vector of 
% real numbers. 
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
%     of the f function is to be plotted. The value of the "Figure" 
%     parameter can be any nonnegative integer. The default 
%     value is "0", at which no figure is to be plotted. 
% 
% "yFit" is the column vector of the estimated values of f("xFit"). 
% 
% "varargout" represents the optional output parameters. The 
% set of the optional parameters depends on the value of the 
% "Type" optional input parameter. 

pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitSpline';
errorMsg = '''xFitA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitSpline);

pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppFitSpline = mkpp(breaks, coefs);

yFitSpline = ppval(ppFitSpline, xFitSpline);

DrawZFitSplineHandle = @DrawZFitSpline;
DrawZFitSplineInput = {xData, yData, min(xFitSpline(1), xData(1)), max(xFitSpline(end), xData(end)), ppFitSpline};
DecideIfDrawZ(DrawZFitSplineHandle, DrawZFitSplineInput, varargin{:});

end

