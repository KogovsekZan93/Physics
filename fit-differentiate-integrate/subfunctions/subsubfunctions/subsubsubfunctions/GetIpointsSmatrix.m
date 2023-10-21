function [Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, Mode)
%% Tool for obtaining the "Ipoints" vector and the 
%% "Smatrix" matrix for the use of ZFind…A functions
% 
% Author: Žan Kogovšek
% Date: 1.24.2023
% Last changed: 10.21.2023
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
% value of the input variable the "Mode" parameter. 
% 
%% Variables
% 
% This function has the form of [Ipoints, Smatrix] = ...
% GetIpointsSmatrix(xData, nA, Mode)
% 
% "xData" is the vectors of the values of the independent 
% variable X. It must be a vector of real numbers in ascending 
% order. 
% 
% "nA" is the number of indices of values of the "xData" vector in 
% each row of the "Smatrix" matrix. 
% 
% "Mode" is the parameter which determines the principle 
% behind calculating the values of the "Ipoints" vector. The value 
% of it must be either "0", "1", or "2". 
% 
% "Ipoints" is a column vector of values of the X variable. Each 
% two consecutive values of the "Ipoints" vector "Ipoints"(i) and 
% "Ipoints"(i + 1) represent the two boundaries of the i-th 
% interpolation polynomial of which consists the piecewise 
% polynomial used by the the ZFind...A . The i-th interpolation 
% polynomial is based on the data points, the independent 
% variable of which is "xData"("Smatrix"(i, :)), i.e. they are the 
% values of the "xData" indexed by the i-th row of the "Smatrix" 
% matrix. 
%    -If "Mode" == 0, each two adjacent values "Ipoints"(i) and 
%     "Ipoints"(i + 1) of the "Ipoints" vector are such that for every 
%     value x of the independent variable X in the interval 
%     ("Ipoints"(i), "Ipoints"(i + 1)), the values of 
%     "xData"("Smatrix"(i, :)) vector are the closest "nA" values of 
%     the "xData" vector to the x value. 
%    -If "Mode" == 1, the values of the "Ipoints" vector are the 
%     same as with "Mode" == 0 with two corrections for 
%     "Ipoints"(i) values other than "Ipoints"(1) and "Ipoints"(end) 
%     (which are "-Inf" and "Inf" respectively). 
%         -The first correction is: if with "Mode" == 0 all values of 
%          the "xData" ("Smatrix"(i, :)) vector are lower than the 
%          "Ipoints"(i) value, the "Ipoints"(i) value with "Mode" == 1 
%          is "Ipoints"(i) == "xData" ("Smatrix"(i, end)). 
%         -The second correction is: if with "Mode" == 0 all values 
%          of the "xData"("Smatrix"(i, :)) vector are higher than the 
%          "Ipoints"(i + 1) value, the "Ipoints"(i + 1) value with 
%          "Mode" == 1 is 
%          "Ipoints"(i + 1) == "xData" ("Smatrix"(i, 1)). 
%    -If "Mode" == 2, the values of the "Ipoints" vector are the 
%     same as with "Mode" == 0 with two corrections for 
%     "Ipoints"(i) values other than "Ipoints"(1) and "Ipoints"(end) 
%     (which are "-Inf" and "Inf" respectively). 
%         -The first correction is: if "Ipoints"(i) value with 
%          "Mode" == 0 is lower than 
%          "xData"("Smatrix"(i, ceil(("nA" - 1) / 2))), the "Ipoints"(i) 
%          value with "Mode" == 2 is 
%          "Ipoints"(i) == "xData"("Smatrix"(i, ceil(("nA" - 1) / 2))). 
%         -The second correction is: if "Ipoints"(i + 1) value with 
%          "Mode" == 0 is higher than 
%          "xData"("Smatrix"(i, "nA" - ceil(("nA" - 1) / 2) + 1)), the 
%          "Ipoints"(i + 1) value with "Mode" == 2 is 
%          "Ipoints"(i + 1) == 
%          "xData"("Smatrix"(i, "nA" - ceil(("nA" - 1) / 2) + 1)). 
% 
% Smatrix is a matrix of "nA" columns and 
% "xDataLength" - "nA" + 1 rows. Each row i contains "nA" 
% consecutive indices of the "xData" vector 
% [i, i + 1, ..., i + "nA" - 2, i + "nA" - 1]. 


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

paramName = 'Mode';
errorMsg = '''Mode'' must be either ''0'', ''1'', or ''2''.';
validationFcn = @(x)assert(x == 0 || x == 1 || x == 2, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, nA, Mode);


xDataLength = length(xData);

% In the following block of code, the "Ipoints" vector is 
% determined for the value of the "Mode" parameter 
% "Mode" == 0. 
Ipoints = zeros(xDataLength - nA + 2, 1);
Ipoints(1) = - inf;
Ipoints(2 : xDataLength - nA + 1) = ...
    (xData(1 : xDataLength - nA) + ...
    xData(nA + 1 : xDataLength)) / 2;
Ipoints(xDataLength - nA + 2) = inf;

% In the following block of code, the "Smatrix" matrix is 
% determined. 
Smatrix = zeros(xDataLength - nA + 1, nA);
indices_from_zero_to_nA_minus_1 =  (0 : nA - 1);
for i = 1 : xDataLength - nA + 1
    Smatrix(i, 1 : nA) = indices_from_zero_to_nA_minus_1 + i;
end

% In the following block of code, "Ipoints" is adjusted 
% appropriately if "Mode" == 1 or if "Mode" == 2. If "nA" == 1, 
% the "Ipoints" vector is the same regardless of the value of the 
% "Mode" parameter. 
if nA > 1
    if Mode == 1
%     Each of the following two four loops deals with each of the 
%     two corrections of the "Ipoints" vector described in the 
%     "Ipoints" vector output parameter description for 
%     "Mode" == 1. 
        for i = 2 : xDataLength - nA + 1
            if Ipoints(i, 1) < xData(Smatrix(i, 1))
                Ipoints(i) = xData(Smatrix(i, 1));
            end
        end
        for i = 1 : xDataLength - nA
            if Ipoints(i + 1) > xData(Smatrix(i, end))
                Ipoints(i + 1) = xData(Smatrix(i, end));
            end
        end
    else
        if Mode == 2
%         Each of the following two four loops deals with each of 
%         the two corrections of the "Ipoints" vector described in 
%         the "Ipoints" vector output parameter description for 
%         "Mode" == 2. 
            OutOfBoundIndex = ceil((nA - 1) / 2);
            for i = 2 : xDataLength - nA + 1
                if Ipoints(i) < xData(Smatrix(i, OutOfBoundIndex))
                    Ipoints(i) = xData(Smatrix(i, OutOfBoundIndex));
                end
            end
            OutOfBoundIndex = nA - OutOfBoundIndex + 1;
            for i = 1 : xDataLength - nA
                if Ipoints(i + 1) > xData(Smatrix(i, OutOfBoundIndex))
                    Ipoints(i + 1) = xData(Smatrix(i, OutOfBoundIndex));
                end
            end
        end
    end
end

end