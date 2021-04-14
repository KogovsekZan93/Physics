function pA = ConstructFunctionPolynomial(xData, yData)

xDataLength = length(xData);

pA = GetFunctionPolynomialCoefficients(xData, yData, xDataLength);

end