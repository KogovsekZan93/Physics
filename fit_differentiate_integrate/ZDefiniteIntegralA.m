function DefiniteIntegralA = ZDefiniteIntegralA(xData, yData, Limits, varargin)
%ZINTEGRALALIMITS Summary of this function goes here
%   Detailed explanation goes here

[LimitsSorted, LimitOrder, ColorFace] = IntegrationLimitsSort(Limits);

[FigureParameter, NonFigureParameters] = SeparateOptionalParameter(varargin, 'Figure');

[yIntegralA, Ipoints, Smatrix] = ZBasicIntegralA(xData, yData, LimitsSorted, NonFigureParameters{:});

DefiniteIntegralA = yIntegralA(2) * LimitOrder;

DrawZIntegralAHandle = @DrawZIntegralA;
DrawZIntegralAInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, Ipoints, Smatrix};
DecideIfDrawZ(DrawZIntegralAHandle, DrawZIntegralAInput, FigureParameter{:});

end