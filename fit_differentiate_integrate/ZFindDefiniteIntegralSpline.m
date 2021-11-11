function DefiniteIntegralSpline = ZFindDefiniteIntegralSpline(xData, yData, Limits, varargin)

[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits(Limits);

[yIndefiniteIntegralSpline, ppFitSpline] = ZFindBasicIntegralSpline(xData, yData, LimitsSorted);

DefiniteIntegralSpline = yIndefiniteIntegralSpline(2) * LimitOrder;

DrawZIntegralSplineHandle = @DrawZIntegralSpline;
DrawZIntegralSplineInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end