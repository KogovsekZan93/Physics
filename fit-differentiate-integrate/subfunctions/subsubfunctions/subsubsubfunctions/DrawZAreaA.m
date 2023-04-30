function DrawZAreaA(xData, yData, xAreaAMin, xAreaAMax, ...
    ColorFace, Ipoints, Smatrix)
%% Tool for plotting the the area under the piecewise 
%% interpolation polynomial curve over an interval
% 
% Author: Žan Kogovšek
% Date: 4.27.2023
% Last changed: 4.30.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the vector 
% "Ipoints" and the matrix "Smatrix", both of which define the fA 
% piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), the values of 
% the X variable the "xAreaAMin" value and the "xAreaAMax" 
% value, and the vector "ColorFace", this function plots the area 
% under the piecewise interpolation polynomial curve from 
% "xAreaAMin" to "xAreaAMax", the color of the area being 
% defined by the RGB triplet of numbers of the "ColorFace" 
% vector. 
% 
%% Variables
% 
% This function has the form of DrawZAreaA(xData, yData, ...
% xAreaAMin, xAreaAMax, ColorFace, Ipoints, Smatrix)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% The "xAreaAMin" parameter and the "xAreaAMax" parameter 
% are two values of the X variable and are the lower and the 
% upper boundary, respectively, of the area to be plotted using 
% this function under the piecewise interpolation polynomial 
% curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). The "xAreaAMax" value must be 
% greater than the "xAreaAMin" value. 
% 
% "ColorFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the piecewise interpolation polynomial 
% curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)) from the value "xAreaAMin" to the 
% "xAreaAMax" value. The three real numbers must be values 
% of the [0, 1] interval. 
% 
% "Ipoints" is a column vector of boundaries between the 
% interpolation polynomials of the piecewise interpolation 
% polynomial fA. Any two consecutive values of the "Ipoints" 
% vector "Ipoints"(i) and "Ipoints"(i + 1) are the boundaries of i-th 
% interpolation polynomial. It must be a sorted column vector of 
% numbers. 
% 
% "Smatrix" is the matrix of rows of indices. Each row 
% "Smatrix"(i, :) contains the indeces k of the data points 
% ("xData"(k), "yData"(k)) which were used to construct the i-th 
% interpolation polynomial p_i of the piecewise interpolation 
% polynomial fA. It must be a matrix of natural numbers the 
% height of which is length("Ipoints") - 1. 


pars = inputParser;

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xAreaAMin';
errorMsg = '''xAreaAMin'' must be a number.';
validationFcn = ...
    @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xAreaAMax';
errorMsg = ...
    '''xAreaAMax'' must be a number which is greater than ''xAreaAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xAreaAMax > xAreaAMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = ...
    '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = ...
    '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = ...
    '''Smatrix'' must be a matrix of natural numbers the hight of which is ''length(Ipoints) - 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    size(x, 1) == length(Ipoints) - 1 && ...
    any(any((mod(x,1) == 0))) && any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xAreaAMin, xAreaAMax, ColorFace, ...
    Ipoints, Smatrix);

% The parameter "N" is set to be "N" = 10 000 and represents 
% the number of points for the area under the piecewise 
% interpolation polynomial curve plot. With this setting, the 
% number of points is typically sufficient to create a convincing 
% illusion of the plotted curve of the function fA being smooth 
% over the intervals over which the fA function is, in fact, smooth. 

N = power(10, 4);

XFitA = (linspace...
    (xAreaAMin, xAreaAMax, N))';
YFitA = EvaluateIpointsSmatrixFit...
    (xData, yData, XFitA, Ipoints, Smatrix);

h = area(XFitA, YFitA);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

end