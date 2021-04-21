function pIntegralA = ConstructIntegralPolynomial(xData, yData)
xDataLength = length(xData);

pIntegralA = GetIntegralPolynomialCoefficients(GetFitPolynomialCoefficients(xData, yData, xDataLength), xDataLength);

end