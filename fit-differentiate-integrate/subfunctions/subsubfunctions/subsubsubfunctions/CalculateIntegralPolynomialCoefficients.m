function pIntegral = CalculateIntegralPolynomialCoefficients(p)


pars = inputParser;

paramName = 'p';
errorMsg = '''p'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, p);

pIntegral = [p./(length(p) : -1 : 1)'; 0];

end