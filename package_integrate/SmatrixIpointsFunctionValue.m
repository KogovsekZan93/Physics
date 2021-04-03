function yEvaluate = SmatrixIpointsFunctionValue(xData, yData, Ipoints, Smatrix, xEvaluate)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here

j = 2;
a = 1;

xEvaluatelength = length(xEvaluate);
yEvaluate = zeros(xEvaluatelength, 1);

while Ipoints(j) <= xEvaluate(1)
    j = j +1;
end

p = ConstructPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

for b = 2 : xEvaluatelength
    if xEvaluate(b) >= Ipoints(j)
        yEvaluate(a : b - 1) = polyval(p,xEvaluate(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xEvaluate(b)
            j = j +1;
        end
        a = b;
        p = ConstructPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yEvaluate(a : end) = polyval(p, xEvaluate(a : end));

 end

