function DefiniteIntegralSpline = ZDefiniteIntegralSpline(xData, yData, Limits, varargin)

[LimitsSorted, LimitOrder, ColorFace] = IntegrationLimitsSort(Limits);

[yIndefiniteIntegralSpline, ppFitSpline] = ZBasicIntegralSpline(xData, yData, LimitsSorted);

DefiniteIntegralSpline = yIndefiniteIntegralSpline(2) * LimitOrder;

DrawZIntegralSplineInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitSpline};
DrawZIntegralSplineHandle = @DrawZIntegralSpline;
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end