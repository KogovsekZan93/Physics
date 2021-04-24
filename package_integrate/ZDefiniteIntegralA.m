function ZDefIntegA = ZDefiniteIntegralA(xData, yData, Limits, varargin)
%ZINTEGRALALIMITS Summary of this function goes here
%   Detailed explanation goes here

[LimitsSorted, LimitOrder, ColorFace] = IntegrationLimitsSort(Limits);

[FigureParameter, vararginBasic] = SeparateOptionalParameter(varargin, 'Figure');

[yIntegralA, Ipoints, Smatrix] = ZBasicIntegralA(xData, yData, LimitsSorted, vararginBasic{:});

ZDefIntegA = yIntegralA(2) * LimitOrder;

DrawZIntegralAInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, Ipoints, Smatrix};
DrawZIntegralAHandle = @DrawZIntegralA;
DrawZDecide(DrawZIntegralAHandle, DrawZIntegralAInput, FigureParameter{:});

end