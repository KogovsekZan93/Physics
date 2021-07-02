function yIntegralA = IpointsSmatrixIntegralValue(xData, yData, xIntegralA, Ipoints, Smatrix)
%SMATRIXIPOINTSFUNCTIONVALUE Summary of this function goes here
%   Detailed explanation goes here


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralA';
errorMsg = '''xIntegralA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = '''Smatrix'' must be a matrix of natural numbers which has the same length as ''Ipoints + 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    length(x) == length(Ipoints) - 1 && ...
    any(any((mod(x,1) == 0))) && any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xIntegralA, Ipoints, Smatrix);


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