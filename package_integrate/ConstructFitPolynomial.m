function pA = ConstructFitPolynomial(xData, yData)

xDataLength = length(xData);

pA = GetFitPolynomialCoefficients(xData, yData, xDataLength);

end