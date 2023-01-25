function [Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode)
%% Tool for obtaining the "Ipoints" vector and the 
%% "Smatrix" matrix for the use of ZFind…A functions
% 
% Author: Žan Kogovšek
% Date: 1.24.2023
% Last changed: 1.25.2023
% 
%% Description
% 
% Given a column vector "xData" of real numbers and a natural 
% number "nA", this function creates groups of "nA" indices in 
% rows of the "Smatrix" matrix and the vector "Ipoints" of values 
% which are used by the ZFind...A functions as the boundaries 
% between interpolation polynomials defined using the groups of 
% the "xData" vector values indexed by the individual rows of the 
% "Smatrix". The values of the "Ipoints" vector is based on the 
% value of the input variable the "mode" parameter. 
% 
%% Variables
% 
% This function has the form of [Ipoints, Smatrix] = ...
% GetIpointsSmatrix(xData, nA, mode)
% 
% "xData" is the vectors of the values of the independent 
% variable X. It must be a vector of real numbers in ascending 
% order. 
% 
% "nA" is the number of indices of values of the "xData" vector in 
% each row of the "Smatrix" matrix. 
% 
% "mode" is the parameter which determines the principle 
% behind calculating the values of the "Ipoints" vector. The value 
% of it must be either "0", "1", or "2". 
% 
% "Ipoints" is a column vector of values of the X variable. Each 
% two consecutive values of the "Ipoints" vector "Ipoints"(i) and 
% "Ipoints"(i + 1) represent the two boundaries of the i-th 
% regression polynomial of which consists the piecewise 
% polynomial used by the the ZFind...A . The i-th regression 
% polynomial is based on the data points, the independent 
% variable of which is "xData"("Smatrix"(i, :)), i.e. they are the 
% values of the "xData" indexed by the i-th row of the "Smatrix" 
% matrix. 
%      If "mode" == 0, each two adjacent values "Ipoints"(i) and 
%      "Ipoints"(i + 1) of the "Ipoints" vector are such that for every 
%      value x of the independent variable X in the interval 
%      ("Ipoints"(i), "Ipoints"(i + 1)), the values of 
%      "xData"("Smatrix"(i, :)) vector are the closest "nA" values of 
%      the "xData" vector to the x value. 
%      If "mode" == 1, the values of the "Ipoints" vector are the 
%      same as with "mode" == 0 with two corrections for 
%      "Ipoints"(i) values other than "Ipoints"(1) and "Ipoints"(end) 
%      (which are "-Inf" and "Inf" respectively). 
%      The first correction is: if with "mode" == 0 all values of the 
%      "xData" ("Smatrix"(i, :)) vector are lower than the "Ipoints"(i) 
%      value, the "Ipoints"(i) value with "mode" == 1 is 
%      "Ipoints"(i) == "xData" ("Smatrix"(i, end)). 
%      The second correction is: if with "mode" == 0 all values of 
%      the "xData"("Smatrix"(i, :)) vector are higher than the 
%      "Ipoints"(i + 1) value, the "Ipoints"(i + 1) value with 
%      "mode" == 1 is "Ipoints"(i + 1) == "xData" ("Smatrix"(i, 1)). 
%      If "mode" == 2, the values of the "Ipoints" vector are the 
%      same as with "mode" == 0 with two corrections for 
%      "Ipoints"(i) values other than "Ipoints"(1) and "Ipoints"(end) 
%      (which are "-Inf" and "Inf" respectively). 
%     The first correction is: if more than bottom(("nA" + 1) / 2) 
%     values of the "xData"("Smatrix"(i, :)) vector are lower than 
%     the "Ipoints"(i) value with "mode" == 0, the "Ipoints"(i) value 
%     with "mode" == 2 is 
%     "Ipoints"(i) == "xData"("Smatrix"(i, floor(("nA" + 1) / 2))). 
%     The second correction is: if more than bottom(("nA" + 1) / 2) 
%     values of the "xData"("Smatrix"(i, :)) vector are higher than 
%     the "Ipoints"(i + 1) value with "mode" == 0, the 
%     "Ipoints"(i + 1) value with "mode" == 2 is "Ipoints"(i + 1) == 
%     "xData"("Smatrix"(i, end + 1 - floor(("nA" + 1) / 2))). 
% 
% Smatrix
% 
%     "Ipoints" is a column vector of boundaries between the 
%     regression polynomials of the piecewise regression 
%     polynomial which is the estimation of the f function. Any two 
%     consecutive values of the "Ipoints"(i : i + 1) vector are the 
%     boundaries of i-th regression polynomial. 
%     "Smatrix" is the matrix of rows of indices. Each row 
%     "Smatrix"(i, :) contains the indeces k of the data points 
%     ("xData"(k), "yData"(k)) which were used to construct the i-th 
%     regressional polynomial of the piecewise regression 
%     polynomial which is the estimation of the f function. 
%     The piecewise polynomial which is used to estimate the f 
%     function can be evaluated by using the parameters "Ipoints" 
%     and "Smatrix" as the input of the EvaluateIpointsSmatrixFit 
%     function. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'nA';
errorMsg = ...
    '''nA'' must be a natural number which is equal to or lower than length(xData).';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0 && x <= length(xData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'mode';
errorMsg = '''mode'' must be either ''0'', ''1'', or ''2''.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, nA, mode);


xDataLength = length(xData);

Ipoints = zeros(xDataLength - nA + 2, 1);
Ipoints(1) = - inf;
Ipoints(2 : xDataLength - nA + 1) = ...
    (xData(1 : xDataLength - nA) + ...
    xData(nA + 1 : xDataLength)) / 2;
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