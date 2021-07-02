function p = GetFitPolynomialCoefficients(xData, yData)

xDataLength = length(xData);


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    xDataLength == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData);


M = ones(xDataLength);

for i = 1 : xDataLength - 1
    M(:, i) = power(xData, xDataLength - i );
end

p = linsolve(M, yData);

end