function yFitSpline = ZFindFitSpline(xData, yData, xFitSpline, varargin)
%ZFITA Summary of this function goes here
%   Detailed explanation goes here


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitSpline';
errorMsg = '''xFitA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitSpline);

pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppFitSpline = mkpp(breaks, coefs);

yFitSpline = ppval(ppFitSpline, xFitSpline);

DrawZFitSplineHandle = @DrawZFitSpline;
DrawZFitSplineInput = {xData, yData, min(xFitSpline(1), xData(1)), max(xFitSpline(end), xData(end)), ppFitSpline};
DecideIfDrawZ(DrawZFitSplineHandle, DrawZFitSplineInput, varargin{:});

end

