function yIndefiniteIntegralSpline = ZFindIndefiniteIntegralSpline(xData, yData, xIntegralSpline, varargin)
%% Numerical spline-based indefinite integration tool
% 
% Author: Žan Kogovšek
% Date: 8.23.2022
% Last changed: 8.23.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the vector "yIndefiniteIntegral" of the estimated values 
% of f("xIntegral") - f("xIntegral"(1)), where "xIntegral" is the input 
% vector of values of the X variable. The estimation is based on 
% the spline interpolation of the data points represented by the 
% pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from "xIntegral"(1) to "xIntegral"(end) along with the data 
% points. 


pars = inputParser;

paramName = 'xIntegralSpline';
errorMsg = '''xIntegralSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralSpline);


[yIndefiniteIntegralSpline, ppFitSpline] = ZFindIntegralSplineBasic(xData, yData, xIntegralSpline);

DrawZIntegralSplineHandle = @DrawZIntegralSpline;
ColorFace = [0, 0, 1];
DrawZIntegralSplineInput = {xData, yData, xIntegralSpline(1), xIntegralSpline(end), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end