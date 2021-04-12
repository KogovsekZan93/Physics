function pA = ConstructPolynomial(xData, yData)

xDataLength = length(xData);

a = GetPolynomialCoefficients(xData, yData, xDataLength);

pA = flipud(a);

end