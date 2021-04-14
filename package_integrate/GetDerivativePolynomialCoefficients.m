function pDerivative = GetDerivativePolynomialCoefficients(p, xDataLength, ordDeriv)

pDerivative = zeros(xDataLength - ordDeriv, 1);

for i = 1 : xDataLength - ordDeriv
    pDerivative(i) = p(i) * factorial(xDataLength - i) / factorial(xDataLength - i - ordDeriv);
end

end