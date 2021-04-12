function yDerivative = SmatrixIpointsDerivativeValue(xData, yData, xDerivative, ordDeriv, Ipoints, Smatrix)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here

j = 2;
a = 1;

xEvaluateLength = length(xDerivative);
yDerivative = zeros(xEvaluateLength, 1);

while Ipoints(j) <= xDerivative(1)
    j = j +1;
end

pDerivativeA = ConstructDerivativePolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)), ordDeriv);

for b = 2 : xEvaluateLength
    if xDerivative(b) >= Ipoints(j)
        yDerivative(a : b - 1) = polyval(pDerivativeA, xDerivative(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xDerivative(b)
            j = j +1;
        end
        a = b;
        pDerivativeA = ConstructDerivativePolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)), ordDeriv);
    end
end

yDerivative(a : end) = polyval(pDerivativeA, xDerivative(a : end));

end