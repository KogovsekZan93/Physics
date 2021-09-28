function yIndefiniteIntegralSpline = ZIndefiniteIntegralSpline(xData, yData, xIntegralSpline, varargin)


pars = inputParser;

paramName = 'xIntegralSpline';
errorMsg = '''xIntegralSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralSpline);


[yIndefiniteIntegralSpline, ppFitSpline] = ZBasicIntegralSpline(xData, yData, xIntegralSpline);

DrawZIntegralSplineHandle = @DrawZIntegralSpline;
ColorFace = [0, 0, 1];
DrawZIntegralSplineInput = {xData, yData, min(xIntegralSpline), max(xIntegralSpline), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end