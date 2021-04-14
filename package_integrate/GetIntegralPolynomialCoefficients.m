function pIntegral = GetIntegralPolynomialCoefficients(p, xDataLength)

pIntegral = [p./(xDataLength : -1 : 1)'; 0];

end