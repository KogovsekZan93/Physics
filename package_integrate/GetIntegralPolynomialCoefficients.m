function pIntegralA = GetIntegralPolynomialCoefficients(xData, yData)


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData);


pIntegralA = CalculateIntegralPolynomialCoefficients(GetFitPolynomialCoefficients(xData, yData));

end