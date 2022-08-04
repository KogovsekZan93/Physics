function [yIntegralPolyFit, varargout] = ZFindIntegralPolyFitBasic(xData, yData, xIntegralPolyFit, PolyDegree)

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

paramName = 'xIntegralPolyFit';
errorMsg = '''xIntegralPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'PolyDegree';
errorMsg = '''PolyDegree'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >=0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xIntegralPolyFit, PolyDegree);


pFitPolyFit = (polyfit(xData, yData, PolyDegree))';
pIntegralPolyFit = CalculateIntegralPolynomialCoefficients(pFitPolyFit);

yIntegralPolyFit = polyval(pIntegralPolyFit, xIntegralPolyFit);
yIntegralPolyFit = yIntegralPolyFit - yIntegralPolyFit(1);
varargout = {pFitPolyFit};

end