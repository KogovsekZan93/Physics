function DefiniteIntegralA = ZFindDefiniteIntegral(xData, yData, Limits, varargin)
%ZINTEGRALALIMITS Summary of this function goes here
%   Detailed explanation goes here

[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits(Limits);

[FigureParameter, NonFigureParameters] = SeparateOptionalParameter(varargin, 'Figure');

[yIntegralA, Ipoints, Smatrix] = ZFindBasicIntegralA(xData, yData, LimitsSorted, NonFigureParameters{:});

DefiniteIntegralA = yIntegralA(2) * LimitOrder;

DrawZIntegralAHandle = @DrawZIntegralA;
DrawZIntegralAInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, Ipoints, Smatrix};
DecideIfDrawZ(DrawZIntegralAHandle, DrawZIntegralAInput, FigureParameter{:});

end