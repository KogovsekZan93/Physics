function DefiniteIntegralA = ZFindDefiniteIntegralA...
    (xData, yData, Limits, varargin)
%% Numerical piecewise interpolation polynomial-based 
%% definite integration tool with visualization
% 
% Author: Žan Kogovšek
% Date: 11.12.2022
% Last changed: 2.10.2024
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X 
% and the input vector 'yData' of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the estimation 'DefiniteIntegralA' of the definite integral 
% f('Limits'(2)) - f('Limits'(1)), where 'Limits' is the input vector of 
% a pair of values of the X variable. The estimation is based on a 
% piecewise interpolation polynomial of the data points 
% represented by the pairs ('xData'(i), 'yData'(i)). 
% The optional parameter named ''Figure'' can be used to plot 
% the estimated curve of the df/dX function and the area under it 
% from min('Limits') to max('Limits'), which is colored based on 
% the order of the pair of values of the 'Limits' vector along with 
% the data points. 
% 
%% Variables
% 
% This function has the form of DefiniteIntegralA = ...
% ZFindDefiniteIntegralA(xData, yData, Limits, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ('yData' = (df/dX)('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. The values of the 
% 'xData' vector must be in ascending order. 
% 
% 'Limits' is the vector of the pair of values of the independent 
% variable X which represent the limits of integration of the df/dX 
% function. Thus, the value of f('Limits'(2)) - f('Limits'(1)) is to be 
% estimated by this function. The 'Limits' vector must be a 
% column vector of two real numbers. 
% 
% 'varargin' represents the optional input parameters named 
% ''PseudoAccuracy'', ''Mode'', and ''Figure''. 
%    -''PseudoAccuracy'' is the name of the parameter the value 
%     of which is the order of the interpolation polynomials from 
%     which the piecewise interpolation polynomial which 
%     represents the df/dX function is composed. It must be a 
%     nonnegative integer. The default value is 0. 
%    -''Mode'' is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise interpolation polynomial which 
%     represents the df/dX function. It must be one of the three 
%     integers: 0, 1, or 2. The default value is 0. 
%    -''Figure'' is the name of the parameter the value of which is 
%     the index of the figure window on which the data points 
%     along with the estimated df/dX function curve is to be 
%     plotted. Also, the area under the estimated df/dX function 
%     curve is filled from min('Limits') to max('Limits'). The color 
%     of the area is red if 'Limits'(1) > 'Limits'(2) and blue if not. 
%     The value of the 'Figure' parameter can be any nonnegative 
%     integer. The default value is 0, at which no figure is to be 
%     plotted. 
% 
% 'DefiniteIntegralA' is the estimated value of the integral of the 
% df/dX function over the X variable with the lower limit 'Limits'(1) 
% and the upper limit 'Limits'(2). 


% The 'ColorFace' parameter, obtained in the following line, 
% determines the color of the area under the estimated curve of 
% the df/dX function: red if 'Limits'(1) > 'Limits'(2) and blue if 
% not. 
[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits...
    (Limits);

[FigureParameter, NonFigureParameters] = ...
    SeparateOptionalParameter(varargin, 'Figure');

[yIntegralA, Ipoints, Smatrix] = ZFindIntegralABasic...
    (xData, yData, LimitsSorted, NonFigureParameters{:});

% In the following line, the estimated definite integral 
% 'DefiniteIntegralA' is calculated by multiplying the 
% 'yIntegralA'(2) value by either 1 or -1 based on the order of 
% the limits on integration. 
DefiniteIntegralA = yIntegralA(2) * LimitOrder;

DrawZIntegralAHandle = @DrawZIntegralA;
DrawZIntegralAInput = {xData, yData, ...
    LimitsSorted(1), LimitsSorted(2), ColorFace, Ipoints, Smatrix};
DecideIfDrawZ(DrawZIntegralAHandle, DrawZIntegralAInput, ...
    FigureParameter{:});

end