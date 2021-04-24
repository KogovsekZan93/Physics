function ZIntegALim = ZIntegralALimits(xData, yData, Limits, varargin)
%ZINTEGRALALIMITS Summary of this function goes here
%   Detailed explanation goes here

[LimitsSorted, LimitOrder, ColorFace] = IntegrationLimitsSort(Limits);

[FigureParameter, vararginBasic] = SeparateOptionalParameter(varargin, 'Figure');

[yIntegralA, Ipoints, Smatrix] = ZIntegralABasic(xData, yData, LimitsSorted, vararginBasic{:});

ZIntegALim = yIntegralA(2) * LimitOrder;

DrawZIntegralAInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, Ipoints, Smatrix};
DrawZIntegralAHandle = @DrawZIntegralA;
DrawZDecide(DrawZIntegralAHandle, DrawZIntegralAInput, FigureParameter{:});

end