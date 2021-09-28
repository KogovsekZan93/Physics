function [yIntegralSpline, varargout] = ZBasicIntegralSpline(xData, yData, xIntegralSpline)


pars = inputParser;

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

paramName = 'xIntegralSpline';
errorMsg = '''xIntegralSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xIntegralSpline);


pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppFitSpline = mkpp(breaks, coefs);
coefsLength = length(coefs);
coefsInteg = [times(coefs, repmat([1/4, 1/3, 1/2, 1], coefsLength, 1)), zeros(coefsLength,1)];

breaksReal = breaks;
breaksReal(1) = - inf; 
breaksReal(end) = inf;

j = 2;
a = 1;

xIntegralSplineLength = length(xIntegralSpline);
yIntegralSpline = zeros(xIntegralSplineLength, 1);

while breaksReal(j) <= xIntegralSpline(1)
    j = j +1;
end

ppIntegralSpline = mkpp([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));

Summa = 0;

for b = 2 : xIntegralSplineLength
    if xIntegralSpline(b) >= breaksReal(j)
        yIntegralSpline(a : b - 1) = Summa + ppval(ppIntegralSpline, xIntegralSpline(a : b - 1)) - ppval(ppIntegralSpline, xIntegralSpline(a));
        Summa = yIntegralSpline(b - 1) + ppval(ppIntegralSpline, breaks(j)) - ppval(ppIntegralSpline, xIntegralSpline(b - 1));
        j = j + 1;
        while breaksReal(j) <= xIntegralSpline(b)
            ppIntegralSpline = mkpp([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));
            Summa = Summa + ppval(ppIntegralSpline, breaks(j)) - ppval(ppIntegralSpline, breaks(j - 1));
            j = j +1;
        end
        a = b;
        ppIntegralSpline = mkpp([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));
    end
end

yIntegralSpline(a : end) = Summa + ppval(ppIntegralSpline, xIntegralSpline(a : end)) - ppval(ppIntegralSpline, max(breaks(j - 1), xIntegralSpline(max(a - 1, 1))));

varargout = {ppFitSpline};

end

