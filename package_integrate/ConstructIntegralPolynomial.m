function p = ConstructIntegralPolynomial(xData, yData)
n = length(xData);
A = ones(n, n);
for i = 2 : n
    A(:, i) = power(xData, i - 1);
end
a = linsolve(A, yData);

for i = 1 : n
    a(i) = a(i) / i;
end
a = [0; a];

p = flipud(a);

end