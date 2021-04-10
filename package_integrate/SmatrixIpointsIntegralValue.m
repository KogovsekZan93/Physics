function yIntegrate = SmatrixIpointsIntegralValue(xData, yData, Ipoints, Smatrix, xIntegrate)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here

j = 2;
a = 1;

xIntegratelength = length(xIntegrate);
yIntegrate = zeros(xIntegratelength, 1);

while Ipoints(j) <= xIntegrate(1)
    j = j +1;
end

p = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

Summa = 0;

for b = 2 : xIntegratelength
    if xIntegrate(b) >= Ipoints(j)
        yIntegrate(a : b - 1) = Summa + polyval(p, xIntegrate(a : b - 1)) - polyval(p, xIntegrate(a));
        Summa = yIntegrate(b - 1) + polyval(p, Ipoints(j)) - polyval(p, xIntegrate(b - 1));
        j = j + 1;
        while Ipoints(j) <= xIntegrate(b)
            p = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
            Summa = Summa + polyval(p, Ipoints(j)) - polyval(p, Ipoints(j - 1));
            j = j +1;
        end
        a = b;
        p = ConstructIntegralPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yIntegrate(a : end) = Summa + polyval(p, xIntegrate(a : end)) - polyval(p, max(Ipoints(j - 1), xIntegrate(max(a - 1, 1))));

end