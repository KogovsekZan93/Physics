function [yDerivativePolyFit, varargout] = ZFindDerivativePolyFitBasic(xData, yData, xDerivativePolyFit, PolyDegree, varargin)

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

paramName = 'xDerivativePolyFit';
errorMsg = '''xDerivativePolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'PolyDegree';
errorMsg = '''PolyDegree'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ... 
    x >=0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, yData, xDerivativePolyFit, PolyDegree, varargin{:});

ordDeriv = pars.Results.OrdDeriv;


pFitPolyFit = (polyfit(xData, yData, PolyDegree))';
pDerivativePolyFit = CalculateDerivativePolynomialCoefficients(pFitPolyFit, ordDeriv);

yDerivativePolyFit = polyval(pDerivativePolyFit, xDerivativePolyFit);
varargout = {pDerivativePolyFit, pFitPolyFit};

end