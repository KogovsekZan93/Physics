function DrawZFitSpline(figr, xData, yData, xFitSplineMin, xFitSplineMax, ppFitSpline)


pars = inputParser;

paramName = 'figure';
errorMsg = '''figure'' must be a natural number.';
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

paramName = 'xFitSplineMin';
errorMsg = '''xFitSplineMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitSplineMax';
errorMsg = '''xFitSplineMax'' must be a number which is greater than ''xFitSplineMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitSplineMax > xFitSplineMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ppFitSpline';
errorMsg = '''ppFitSpline'' must be a structure array.';
validationFcn = @(x)assert(isstruct(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xFitSplineMin, xFitSplineMax, ppFitSpline);


N = 1000;

figure(figr)
clf;
hold on;

xFitSpline = (linspace(xFitSplineMin, xFitSplineMax, N))';
yFitSpline = ppval(ppFitSpline, xFitSpline);
plot(xFitSpline, yFitSpline, 'r', 'LineWidth', 1.2);

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end