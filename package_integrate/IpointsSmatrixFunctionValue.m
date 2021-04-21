function yEvaluate = IpointsSmatrixFunctionValue(xData, yData, xEvaluate, Ipoints, Smatrix)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here

j = 2;
a = 1;

xEvaluateLength = length(xEvaluate);
yEvaluate = zeros(xEvaluateLength, 1);

while Ipoints(j) <= xEvaluate(1)
    j = j +1;
end

pA = ConstructFitPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

for b = 2 : xEvaluateLength
    if xEvaluate(b) >= Ipoints(j)
        yEvaluate(a : b - 1) = polyval(pA, xEvaluate(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xEvaluate(b)
            j = j +1;
        end
        a = b;
        pA = ConstructFitPolynomial(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yEvaluate(a : end) = polyval(pA, xEvaluate(a : end));

end