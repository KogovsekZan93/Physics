function [Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode)
%GETSMATRIXIPOINTS Summary of this function goes here
%   Detailed explanation goes here


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'nA';
errorMsg = '''nA'' must be a natural number, equal to or lower than length(xData).';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0 && x < length(xData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'mode';
errorMsg = '''mode'' must be either ''0'', ''1'', or ''2''.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, nA, mode);


xDataLength = length(xData);

Ipoints = zeros(xDataLength - nA + 2, 1);
Ipoints(1) = - inf;
Ipoints(2 : xDataLength - nA + 1) = (xData(1 : xDataLength - nA) + xData(nA + 1 : xDataLength)) / 2;
Ipoints(xDataLength - nA + 2) = inf;

Smatrix = zeros(xDataLength - nA + 1, nA);
for i = 1 : xDataLength - nA + 1
    Smatrix(i, 1 : nA) = (1 : nA) + i - 1;
end

if mode == 1 && nA > 1
    for i = 1 : xDataLength - nA
        if Ipoints(i + 1) > xData(Smatrix(i, end))
            Ipoints(i + 1) = xData(Smatrix(i, end));
        end
    end
    for i = 2 : xDataLength - nA + 1
        if Ipoints(i, 1) < xData(Smatrix(i, 1))
            Ipoints(i) = xData(Smatrix(i, 1));
        end
    end
else
    if mode == 2 && nA > 1
        for i = 1 : xDataLength - nA
            if Ipoints(i + 1) > xData(Smatrix(i, floor((nA + 3) / 2)))
                Ipoints(i + 1) = xData(Smatrix(i, floor((nA + 3) / 2)));
            end
        end
        for i = 2 : xDataLength - nA + 1
            if Ipoints(i) < xData(Smatrix(i, ceil((nA - 1) / 2)))
                Ipoints(i) = xData(Smatrix(i, ceil((nA - 1) / 2)));
            end
        end
    end
end

end