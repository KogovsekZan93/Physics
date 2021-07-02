function pIntegralA = ConstructIntegralPolynomial(xData, yData)


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData);


pIntegralA = GetIntegralPolynomialCoefficients(GetFitPolynomialCoefficients(xData, yData));

end