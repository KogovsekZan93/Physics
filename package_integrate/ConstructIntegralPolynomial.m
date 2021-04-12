function pIntegralA = ConstructIntegralPolynomial(xData, yData)
xDataLength = length(xData);

a = [0; GetPolynomialCoefficients(xData, yData, xDataLength)./(1 : xDataLength)'];

pIntegralA = flipud(a);

end