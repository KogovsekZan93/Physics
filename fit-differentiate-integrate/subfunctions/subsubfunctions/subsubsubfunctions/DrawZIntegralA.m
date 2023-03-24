function DrawZIntegralA...
    (figr, xData, yData, xIntegralAMin, xIntegralAMax, ...
    ColorFace, Ipoints, Smatrix)
%% Tool for plotting the data points, the piecewise 
%% interpolation polynomial curve, and the area under the 
%% curve over an interval
% 
% Author: Žan Kogovšek
% Date: 3.24.2023
% Last changed: 3.24.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), as well as the vector 
% "Ipoints" and the matrix "Smatrix", both of which define the 
% fA piecewise interpolation polynomial of the data points 
% represented by the pairs ("xData"(i), "yData"(i)), the values of 
% the X variable the "xIntegralAMin" value and the 
% "xIntegralAMax" value, the natural number "figr", and the 
% vector "ColorFace", this function plots the data points, the 
% piecewise interpolation polynomial curve of the data points 
% and the area under the piecewise interpolation polynomial 
% curve from "xIntegralAMin" to "xIntegralAMax", the color of the 
% area being defined by the RGB triplet of numbers of the 
% "ColorFace" vector. 
% 
%% Variables
% 
% This function has the form of DrawZIntegralA
% (figr, xData, yData, xIntegralAMin, xIntegralAMax, ColorFace, ...
% Ipoints, Smatrix)
% 
% "figr" is the parameter the value of which is the index of the 
% figure on which the data points, the piecewise interpolation 
% polynomial curve, and the area under the curve described in 
% the Description section is to be plotted. The value of the "figr" 
% parameter must be a natural number. 
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% The "xIntegralAMin" parameter and the "xIntegralAMax" 
% parameter are two values of the X variable and are the lower 
% and the upper boundary, respectively, of the area to be plotted 
% using this function under the piecewise interpolation 
% polynomial curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). The "xIntegralAMax" value must be 
% greater than the "xIntegralAMin" value. 
% 
% "ColoFace" is the horizontal vector of three real numbers 
% which represents the RGB triplet which is to be used to set the 
% color of the area under the piecewise interpolation polynomial 
% curve of the data points represented by the pairs 
% ("xData"(i), "yData"(i)) from the value "xIntegralAMin" to the 
% "xIntegralAMax" value. The three real numbers must be values 
% of the [0, 1] interval. 
% 
% Ipoints, Smatrix


pars = inputParser;

paramName = 'figr';
errorMsg = '''figr'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

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

paramName = 'xIntegralAMin';
errorMsg = '''xIntegralAMin'' must be a number.';
validationFcn = @(x)assert...
    (isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralAMax';
errorMsg = ...
    '''xIntegralAMax'' must be a number which is greater than ''xIntegralAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralAMax > xIntegralAMin, errorMsg);
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

parse(pars, figr, xData, yData, xIntegralAMin, xIntegralAMax, ...
    ColorFace, Ipoints, Smatrix);


figure(figr)
clf;
hold on;

N = 1000;

IpointsLength = length(Ipoints);

%     The following lines contain three sections, each separated 
%     from the next by an empty line. They deal with the X values 
%     lower than Ipoints(2) (first section), higher than 
%     Ipoints(end - 1) (third section) and the intermediary values 
%     (second section), respectively. In each section, the vector 
%     of coefficients p of the appropriate Lagrange polynomial is 
%     calculated. Then the Lagrange polynomial is plotted over an 
%     appropriate interval. Finally, the area under the curve which 
%     represents the integral is plotted. 

nA = length(Smatrix(1, :));
M = ones(nA);
for j = 1 : nA - 1
    M(:, j) = power(xData(Smatrix(1, :)), nA - j);
end
pA = linsolve(M, yData(Smatrix(1, :)));
if xIntegralAMin < Ipoints(2)
    XFitA = (linspace(xIntegralAMin, min(xIntegralAMax, Ipoints(2)), N))';
    YFitA = polyval(pA, XFitA);
    h = area(XFitA, YFitA);
    h.FaceColor = ColorFace;
    h.FaceAlpha = 0.3;
end
xFitA = (linspace(min(min(xData), xIntegralAMin), min(Ipoints(2), max(max(xData), xIntegralAMax)), N))';
yFitA = polyval(pA, xFitA);
plot(xFitA, yFitA, 'r', 'LineWidth', 1.2);

for i = 2 : IpointsLength - 2
    for j = 1 : nA - 1
        M(:, j) = power(xData(Smatrix(i, :)), nA - j);
    end
    pA = linsolve(M, yData(Smatrix(i, :)));
    if xIntegralAMin >= Ipoints(i) && xIntegralAMin <= Ipoints(i + 1)
        XFitA = (linspace(xIntegralAMin, min(xIntegralAMax, Ipoints(i + 1)), N))';
        YFitA = polyval(pA, XFitA);
        h = area(XFitA, YFitA);
        h.FaceColor = ColorFace;
        h.FaceAlpha = 0.3;
    else
        if xIntegralAMin <= Ipoints(i) && xIntegralAMax >= Ipoints(i)
            XFitA = (linspace(Ipoints(i), min(Ipoints(i + 1), xIntegralAMax), N))';
            YFitA = polyval(pA, XFitA);
            h = area(XFitA, YFitA);
            h.FaceColor = ColorFace;
            h.FaceAlpha = 0.3;
        end
    end    
    xFitA = (linspace(Ipoints(i), Ipoints(i + 1), N))';
    yFitA = polyval(pA, xFitA);
    plot(xFitA, yFitA, 'r','LineWidth', 1.2);
end

if IpointsLength ~= 2
    for j = 1 : nA - 1
        M(:, j) = power(xData(Smatrix(IpointsLength - 1, :)), nA - j);
    end
    pA = linsolve(M, yData(Smatrix(IpointsLength - 1, :)));
    if xIntegralAMax > Ipoints(IpointsLength - 1)
        XFitA = (linspace(max(xIntegralAMin, Ipoints(IpointsLength - 1)), xIntegralAMax, N))';
        YFitA = polyval(pA, XFitA);
        h = area(XFitA, YFitA);
        h.FaceColor = ColorFace;
        h.FaceAlpha = 0.3;
    end
    xFitA = (linspace(Ipoints(IpointsLength - 1), max(max(xData), xIntegralAMax), N))';
    yFitA = polyval(pA, xFitA);
    plot(xFitA, yFitA, 'r', 'LineWidth', 1.2);
end

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14);
grid on;
hold off;

end