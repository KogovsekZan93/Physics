function DrawZIntegralPolyFit(figr, xData, yData, xIntegralPolyFitMin, xIntegralPolyFitMax, ColorFace, pFitPolyFit)

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

paramName = 'xIntegralPolyFitMin';
errorMsg = '''xIntegralPolyFitMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralPolyFitMax';
errorMsg = '''xIntegralPolyFitMax'' must be a number which is greater than ''xIntegralPolyFitMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralPolyFitMax > xIntegralPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'pFitPolyFit';
errorMsg = '''pFitPolyFit'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xIntegralPolyFitMin, xIntegralPolyFitMax, ColorFace, pFitPolyFit);


figure(figr)
clf;
hold on;

N = 1000;

XFitPolyFit = (linspace(xIntegralPolyFitMin, xIntegralPolyFitMax, N))';
YFitPolyFit = polyval(pFitPolyFit, XFitPolyFit);
h = area(XFitPolyFit, YFitPolyFit);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

xFitPolyFit = (linspace(min(xData(1), xIntegralPolyFitMin), max(xData(end), xIntegralPolyFitMax), N))';
yFitPolyFit = polyval(pFitPolyFit, xFitPolyFit);
plot(xFitPolyFit, yFitPolyFit, 'r', 'LineWidth', 1.2);

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end