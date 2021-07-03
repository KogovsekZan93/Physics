function yIntegralSpline = ZIndefiniteIntegralSpline(xData, yData, xIntegralSpline, varargin)

[yIntegralSpline, ppData] = ZBasicIntegralSpline(xData, yData, xIntegralSpline);


ColorFace = [0, 0, 1];
DrawZIntegralSplineInput = {xData, yData, min(xIntegralSpline), max(xIntegralSpline), ColorFace, ppData};
DrawZIntegralSplineHandle = @DrawZIntegralSpline;
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end