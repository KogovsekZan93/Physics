function yIntegralA = IpointsSmatrixIntegralValue(xData, yData, xIntegralA, Ipoints, Smatrix)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here

j = 2;
a = 1;

xIntegralALength = length(xIntegralA);
yIntegralA = zeros(xIntegralALength, 1);

while Ipoints(j) <= xIntegralA(1)
    j = j +1;
end

pIntegralA = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

Summa = 0;

for b = 2 : xIntegralALength
    if xIntegralA(b) >= Ipoints(j)
        yIntegralA(a : b - 1) = Summa + polyval(pIntegralA, xIntegralA(a : b - 1)) - polyval(pIntegralA, xIntegralA(a));
        Summa = yIntegralA(b - 1) + polyval(pIntegralA, Ipoints(j)) - polyval(pIntegralA, xIntegralA(b - 1));
        j = j + 1;
        while Ipoints(j) <= xIntegralA(b)
            pIntegralA = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
            Summa = Summa + polyval(pIntegralA, Ipoints(j)) - polyval(pIntegralA, Ipoints(j - 1));
            j = j +1;
        end
        a = b;
        pIntegralA = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yIntegralA(a : end) = Summa + polyval(pIntegralA, xIntegralA(a : end)) - polyval(pIntegralA, max(Ipoints(j - 1), xIntegralA(max(a - 1, 1))));

end