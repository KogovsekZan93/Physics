function p = ConstructPolynomial(xData, yData)

n = length(xData);
A = ones(n, n);
for j = 2 : n
    A(:,j) = power(xData, j - 1);
end
a = linsolve(A, yData);
p = flipud(a);

end