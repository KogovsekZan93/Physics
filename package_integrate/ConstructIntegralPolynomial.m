function pIntegralA = ConstructIntegralPolynomial(xData, yData)
xDataLength = length(xData);

pIntegralA = GetIntegralPolynomialCoefficients(GetFunctionPolynomialCoefficients(xData, yData, xDataLength), xDataLength);

end