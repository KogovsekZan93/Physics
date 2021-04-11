function p = ConstructPolynomial(xData, yData)

xDataLength = length(xData);

a = GetPolynomialCoefficients(xData, yData, xDataLength);

p = flipud(a);

end