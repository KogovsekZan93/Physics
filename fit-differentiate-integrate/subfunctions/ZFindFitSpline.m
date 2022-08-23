function yFitSpline = ZFindFitSpline(xData, yData, xFitSpline, varargin)
%% Spline curve fitting tool with visualization
% 
% Author: Žan Kogovšek
% Date: 8.23.2022
% Last changed: 8.23.2022
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

