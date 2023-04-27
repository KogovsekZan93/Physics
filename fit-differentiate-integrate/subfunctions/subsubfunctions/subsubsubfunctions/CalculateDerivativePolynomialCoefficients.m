function pDerivative = ...
    CalculateDerivativePolynomialCoefficients(p, ordDeriv)


pars = inputParser;

paramName = 'p';
errorMsg = '''p'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ordDeriv';
errorMsg = '''ordDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, p, ordDeriv);

pLength = length(p);
pDerivative = zeros(pLength - ordDeriv, 1);

for i = 1 : pLength - ordDeriv
    pDerivative(i) = ...
        p(i) * factorial(pLength - i) / factorial(pLength - i - ordDeriv);
end

end