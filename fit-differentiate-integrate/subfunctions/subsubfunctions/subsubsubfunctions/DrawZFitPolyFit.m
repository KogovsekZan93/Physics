function DrawZFitPolyFit(figr, xData, yData, xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit)


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

paramName = 'xFitPolyFitMin';
errorMsg = '''xFitSplineMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFitMax';
errorMsg = '''xFitSplineMax'' must be a number which is greater than ''xFitSplineMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitPolyFitMax > xFitPolyFitMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'pFitPolyFit';
errorMsg = '''pFitPolyFit'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xFitPolyFitMin, xFitPolyFitMax, pFitPolyFit);


N = power(10, 4);

figure(figr);


xFitPolyFit = (linspace(xFitPolyFitMin, xFitPolyFitMax, N))';
yFitPolyFit = polyval(pFitPolyFit, xFitPolyFit);
plot(xFitPolyFit, yFitPolyFit, 'r', 'LineWidth', 1.2);
hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end