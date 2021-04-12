function pDerivativeA = ConstructDerivativePolynomial(xData, yData, ordDeriv)
xDataLength = length(xData);

a = GetPolynomialCoefficients(xData, yData, xDataLength);

for i = ordDeriv + 1 : xDataLength
    a(i) = a(i) * factorial(i - 1) / factorial(i - 1 - ordDeriv);
end

a = a(ordDeriv + 1 : end);

pDerivativeA = flipud(a);

end