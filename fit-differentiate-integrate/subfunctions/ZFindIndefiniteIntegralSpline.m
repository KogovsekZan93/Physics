function yIndefiniteIntegralSpline = ZFindIndefiniteIntegralSpline(xData, yData, xIntegralSpline, varargin)


pars = inputParser;

paramName = 'xIntegralSpline';
errorMsg = '''xIntegralSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralSpline);


[yIndefiniteIntegralSpline, ppFitSpline] = ZFindIntegralSplineBasic(xData, yData, xIntegralSpline);

DrawZIntegralSplineHandle = @DrawZIntegralSpline;
ColorFace = [0, 0, 1];
DrawZIntegralSplineInput = {xData, yData, xIntegralSpline(1), xIntegralSpline(end), ColorFace, ppFitSpline};
DecideIfDrawZ(DrawZIntegralSplineHandle, DrawZIntegralSplineInput, varargin{:});

end