function yIntegrate = SmatrixIpointsIntegralValue(xData, yData, Ipoints, Smatrix, xIntegrate)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here

j = 2;
a = 1;

xIntegrateLength = length(xIntegrate);
yIntegrate = zeros(xIntegrateLength, 1);

while Ipoints(j) <= xIntegrate(1)
    j = j +1;
end

pIntegral = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

Summa = 0;

for b = 2 : xIntegrateLength
    if xIntegrate(b) >= Ipoints(j)
        yIntegrate(a : b - 1) = Summa + polyval(pIntegral, xIntegrate(a : b - 1)) - polyval(pIntegral, xIntegrate(a));
        Summa = yIntegrate(b - 1) + polyval(pIntegral, Ipoints(j)) - polyval(pIntegral, xIntegrate(b - 1));
        j = j + 1;
        while Ipoints(j) <= xIntegrate(b)
            pIntegral = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
            Summa = Summa + polyval(pIntegral, Ipoints(j)) - polyval(pIntegral, Ipoints(j - 1));
            j = j +1;
        end
        a = b;
        pIntegral = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yIntegrate(a : end) = Summa + polyval(pIntegral, xIntegrate(a : end)) - polyval(pIntegral, max(Ipoints(j - 1), xIntegrate(max(a - 1, 1))));

end