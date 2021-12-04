function DrawZIntegralSpline(figr, xData, yData, xIntegralSplineMin, xIntegralSplineMax, ColorFace, ppFitSpline)


pars = inputParser;

paramName = 'figr';
errorMsg = '''figr'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralMin';
errorMsg = '''xIntegralMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralMax';
errorMsg = '''xIntegralMax'' must be a number which is greater than ''xIntegralMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralSplineMax > xIntegralSplineMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ppFitSpline';
errorMsg = '''ppFitSpline'' must be a structure array.';
validationFcn = @(x)assert(isstruct(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xIntegralSplineMin, xIntegralSplineMax, ColorFace, ppFitSpline);


N = 1000;

figure(figr)
clf;
hold on;

XFitSpline = (linspace(xIntegralSplineMin, xIntegralSplineMax, N))';
YFitSpline = ppval(ppFitSpline, XFitSpline);
h = area(XFitSpline, YFitSpline);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

xFitSpline = (linspace(min(min(xData), xIntegralSplineMin), max(max(xData), xIntegralSplineMax), N))';
yFitSpline = ppval(ppFitSpline, xFitSpline);
plot(xFitSpline, yFitSpline, 'r', 'LineWidth', 1.2);

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end