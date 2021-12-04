function yDerivativeA = EvaluateIpointsSmatrixDerivative(xData, yData, xDerivativeA, ordDeriv, Ipoints, Smatrix)
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

paramName = 'xDerivativeA';
errorMsg = '''xDerivativeA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = '''Smatrix'' must be a matrix of natural numbers the hight of which is ''length(Ipoints) - 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    size(x, 1) == length(Ipoints) - 1 && ...
    any(any((mod(x,1) == 0))) && any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xDerivativeA, Ipoints, Smatrix);


j = 2;
a = 1;

xDerivativeALength = length(xDerivativeA);
yDerivativeA = zeros(xDerivativeALength, 1);

while Ipoints(j) <= xDerivativeA(1)
    j = j +1;
end

pDerivativeA = GetDerivativePolynomialCoefficients(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)), ordDeriv);

for b = 2 : xDerivativeALength
    if xDerivativeA(b) >= Ipoints(j)
        yDerivativeA(a : b - 1) = polyval(pDerivativeA, xDerivativeA(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xDerivativeA(b)
            j = j +1;
        end
        a = b;
        pDerivativeA = GetDerivativePolynomialCoefficients(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)), ordDeriv);
    end
end

yDerivativeA(a : end) = polyval(pDerivativeA, xDerivativeA(a : end));

end