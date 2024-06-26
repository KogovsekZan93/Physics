function DefiniteIntegralPolyFit = ZFindDefiniteIntegralPolyFit...
    (xData, yData, Limits, PolyDegree, varargin)
%% Numerical polynomial regression-based definite integration tool with 
%% visualization
% 
% Author: �an Kogov�ek
% Date: 9.11.2022
% Last changed: 5.29.2024
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X and the 
% input vector 'yData' of the values of the dependent variable Y of an 
% arbitrary function Y = (df/dX)(X), this function returns the estimation 
% 'DefiniteIntegralPolyFit' of the definite integral 
% f('Limits'(2)) - f('Limits'(1)), where 'Limits' is the input vector of a 
% pair of values of the X variable. The estimation is based on the 
% polynomial regression of the data points represented by the pairs 
% ('xData'(i), 'yData'(i)). 
% The optional parameter named ''Figure'' can be used to plot the 
% estimated curve of the df/dX function and the area under it from 
% min('Limits') to max('Limits'), which is colored based on the order of 
% the pair of values of the 'Limits' vector along with the data points. 
% 
%% Variables
% 
% This function has the form of DefiniteIntegralPolyFit = ...
% ZFindDefiniteIntegralPolyFit(xData, yData, Limits, PolyDegree, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the independent 
% variable X and of the dependent variable Y, respectively, of an 
% arbitrary function Y = (df/dX)(X) ('yData' = (df/dX)('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column vectors of 
% equal length and of real numbers. The values of the 'xData' vector must 
% be in ascending order. 
% 
% 'Limits' is the vector of the pair of values of the independent variable 
% X which represent the limits of integration of the df/dX function. Thus, 
% the value of f('Limits'(2)) - f('Limits'(1)) is to be estimated by this 
% function. The 'Limits' vector must be a column vector of two real 
% numbers. 
% 
% 'PolyDegree' is the degree of the regression polynomial of the data 
% points represented by the pairs ('xData'(i), 'yData'(i)), which is the 
% estimation of the f function. The 'PolyDegree' degree must be a 
% nonnegative integer. 
% 
% 'varargin' represents the optional input parameter named ''Figure''. The 
% value of the 'Figure' parameter is the index of the figure window on 
% which the data points along with the estimated df/dX function curve is 
% to be plotted. Also, the area under the estimated df/dX function curve 
% is filled from min('Limits') to max('Limits'). The color of the area is 
% red if 'Limits'(1) > 'Limits'(2) and blue if not. 
% The value of the 'Figure' parameter can be any nonnegative integer. The 
% default value is 0, at which no figure is to be plotted. 
% 
% 'DefiniteIntegralPolyFit' is the estimated value of the integral of the 
% df/dX function over the X variable with the lower limit 'Limits'(1) and 
% the upper limit 'Limits'(2). 


% The 'ColorFace' parameter, obtained in the following line, determines 
% the color of the area under the estimated curve of the df/dX function: 
% red if 'Limits'(1) > 'Limits'(2) and blue if not. 
[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits...
    (Limits);

[yIntegralPolyFit, ppFitPolyFit] = ZFindIntegralPolyFitBasic...
    (xData, yData, LimitsSorted, PolyDegree);

% In the following line, the estimated definite integral 
% 'DefiniteIntegralPolyFit' is calculated by multiplying the 
% 'yIntegralPolyFit'(2) value by either 1 or -1 based on the order of the 
% limits on integration. 
DefiniteIntegralPolyFit = yIntegralPolyFit(2) * LimitOrder;

% The following block of code deals with plotting the estimated curve of 
% the df/dX function and the area under it from min('Limits') to 
% max('Limits') along with the data points. 
DrawZIntegralPolyFitHandle = @DrawZIntegralPolyFit;
DrawZIntegralPolyFitInput = {xData, yData, ...
    LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitPolyFit};
DecideIfDrawZ(DrawZIntegralPolyFitHandle, DrawZIntegralPolyFitInput, ...
    varargin{:});

end