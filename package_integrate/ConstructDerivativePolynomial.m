function pDerivativeA = ConstructDerivativePolynomial(xData, yData, ordDeriv)
xDataLength = length(xData);

pDerivativeA = GetDerivativePolynomialCoefficients(GetFitPolynomialCoefficients(xData, yData, xDataLength), xDataLength, ordDeriv);

end