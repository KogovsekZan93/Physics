function pIntegral = ConstructIntegralPolynomial(xData, yData)
xDataLength = length(xData);

a = [0; GetPolynomialCoefficients(xData, yData, xDataLength)./(1 : xDataLength)'];

pIntegral = flipud(a);

end