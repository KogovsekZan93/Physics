function p = GetFitPolynomialCoefficients(xData, yData, xDataLength)

M = ones(xDataLength);

for i = 1 : xDataLength - 1
    M(:, i) = power(xData, xDataLength - i );
end

p = linsolve(M, yData);

end