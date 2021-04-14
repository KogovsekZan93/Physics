function p = GetFunctionPolynomialCoefficients(xData, yData, xDataLength)

A = ones(xDataLength);

for i = 1 : xDataLength - 1
    A(:, i) = power(xData, xDataLength - i );
end

p = linsolve(A, yData);

end