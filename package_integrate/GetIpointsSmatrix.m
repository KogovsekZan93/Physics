function [Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode)
%GETSMATRIXIPOINTS Summary of this function goes here
%   Detailed explanation goes here
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

