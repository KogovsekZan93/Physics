function pDerivativeA = GetDerivativePolynomialCoefficients(xData, yData, ordDeriv)

pDerivativeA = CalculateDerivativePolynomialCoefficients(GetFitPolynomialCoefficients(xData, yData), ordDeriv);

end