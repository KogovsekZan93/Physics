function DefiniteIntegralSpline = ZFindDefiniteIntegralSpline(xData, yData, Limits, varargin)
%% Numerical spline-based definite integration tool
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
% returns the estimation "DefiniteIntegral" of the definite integral 
% f("Limits"(2)) - f("Limits"(1)), where "Limits" is the input vector 
% of a pair of values of the X variable. The estimation is based 
% on the spline interpolation of the data points represented by 
% the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from min("Limits") to max("Limits"), which is colored based on 
% the order of the pair of values of the "Limits" vector along with 
% the data points. 



[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits(Limits);

[yIndefiniteIntegralSpline, ppFitSpline] = ZFindIntegralSplineBasic(xData, yData, LimitsSorted);

DefiniteIntegralSpline = yIndefiniteIntegralSpline(2) * LimitOrder;

DrawZIntegralSplineHandle = @DrawZIntegralSpline;
DrawZIntegralSplineInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end