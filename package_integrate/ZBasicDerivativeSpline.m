function [yDerivativeSpline, varargout] = ZBasicDerivativeSpline(xData, yData, xDerivativeSpline, varargin)


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

paramName = 'xDerivativeSpline';
errorMsg = '''xDerivativeSpline'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
defaultVal = 1;
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, xData, yData, xDerivativeSpline, varargin{:});

ordDeriv = pars.Results.OrdDeriv;


pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppFitSpline = mkpp(breaks, coefs);

coefsDeriv = coefs;

if ordDeriv < 4
    for i = 1 : ordDeriv
        ordPoly = length(coefsDeriv(1, :)) - 1;
        coefsDeriv = times(coefsDeriv(:, 1 : ordPoly), repmat((ordPoly : -1 : 1), length(coefsDeriv(:,1)), 1));
    end
else
     coefsDeriv = zeros(length(coefsDeriv(:,1)),1);
end

ppDerivativeSpline = mkpp(breaks, coefsDeriv);
varargout = {ppDerivativeSpline, ppFitSpline};

yDerivativeSpline = ppval(ppDerivativeSpline, xDerivativeSpline);

end