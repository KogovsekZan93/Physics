function a = GetPolynomialCoefficients(xData, yData, xDataLength)

A = ones(xDataLength);

for i = 2 : xDataLength
    A(:, i) = power(xData, i - 1);
end

a = linsolve(A, yData);

end