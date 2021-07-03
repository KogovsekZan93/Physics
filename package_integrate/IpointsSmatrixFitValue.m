function yFitA = IpointsSmatrixFitValue(xData, yData, xFitA, Ipoints, Smatrix)
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

paramName = 'xFitA';
errorMsg = '''xFitA'' must be a sorted column vector of numbers.';
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

parse(pars, xData, yData, xFitA, Ipoints, Smatrix);


j = 2;
a = 1;

xFitALength = length(xFitA);
yFitA = zeros(xFitALength, 1);

while Ipoints(j) <= xFitA(1)
    j = j +1;
end

p = GetFitPolynomialCoefficients(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));

for b = 2 : xFitALength
    if xFitA(b) >= Ipoints(j)
        yFitA(a : b - 1) = polyval(p, xFitA(a : b - 1));
        j = j + 1;
        while Ipoints(j) <= xFitA(b)
            j = j +1;
        end
        a = b;
        p = GetFitPolynomialCoefficients(xData(Smatrix(j - 1, :)), yData(Smatrix(j - 1, :)));
    end
end

yFitA(a : end) = polyval(p, xFitA(a : end));

end