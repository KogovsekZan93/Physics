function pDerivativeA = ConstructDerivativePolynomial(xData, yData, ordDeriv)
xDataLength = length(xData);

pDerivativeA = GetDerivativePolynomialCoefficients(GetFunctionPolynomialCoefficients(xData, yData, xDataLength), xDataLength, ordDeriv);

end