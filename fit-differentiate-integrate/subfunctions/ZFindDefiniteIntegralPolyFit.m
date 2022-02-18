function DefiniteIntegralPolyFit = ZFindDefiniteIntegralPolyFit(xData, yData, Limits, PolyDegree,varargin)

[LimitsSorted, LimitOrder, ColorFace] = SortIntegrationLimits(Limits);

[yIndefiniteIntegralSpline, ppFitSpline] = ZFindIntegralPolyFitBasic(xData, yData, LimitsSorted, PolyDegree);

DefiniteIntegralPolyFit = yIndefiniteIntegralSpline(2) * LimitOrder;

DrawZIntegralPolyFitHandle = @DrawZIntegralPolyFit;
DrawZIntegralPolyFitInput = {xData, yData, LimitsSorted(1), LimitsSorted(2), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralPolyFitHandle, DrawZIntegralPolyFitInput, varargin{:});

end