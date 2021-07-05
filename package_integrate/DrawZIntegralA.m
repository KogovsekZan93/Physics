function DrawZIntegralA(figr, xData, yData, xIntegralAMin, xIntegralAMax, ColorFace, Ipoints, Smatrix)
%% Visualization of numerical integration with ZIntegralA
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Using this function, the visualization of the numerical 
% integration with ZIntegralA is plotted in the figure figure(figr). 
% The input values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X) are plotted as blue circles (i.e. (x(i),y(i)) points), the 
% approximation of the f function is plotted as a red line and the 
% integral is plotted as the semi-transparent area under the red 
% curve. The semi-transparent area is blue if the original upper 
% limit of integration has a higher value than the original lower 
% limit of integration, and is red if that is not the case. 
%
%% Variables
% 
% This function has the form of 
% DrawZIntegA(x, y, Ipoints, Smatrix, xmin, xmax, figr)
% 
% x and y are the vectors of the aforementioned values x(i) and 
% y(i), respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors 
% of real numbers of equal length. x vector has to be sorted (i.e. 
% it is required that x(i) > x(j) for every i > j). 
% 
% Ipoints is a column vector and Smatrix is a matrix. For each 
% interval [Ipoints(k), Ipoints(k+1)], the plotted approximation of 
% the f function will be the Lagrange polynomial which is based 
% on the set {(x(i), y(i)) | i is in Smatrix(k, :)}. 
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval. 
% 
% LimitOrder is the indicator of whether the original input 
% xmax < xmin or not, and has the value “-1” in the former case 
% and the value “1” in the latter case. 
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. 
 

%     N represents the number of points with which each section 
%     of the approximation of the function and the integral will be 
%     plotted. 


pars = inputParser;

paramName = 'figure';
errorMsg = '''figure'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

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

paramName = 'xIntegralAMin';
errorMsg = '''xIntegralAMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xIntegralAMax';
errorMsg = '''xIntegralAMax'' must be a number which is greater than ''xIntegralAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xIntegralAMax > xIntegralAMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = '''Smatrix'' must be a matrix of natural numbers the length of which is ''length(Ipoints) - 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    length(x) == length(Ipoints) - 1 && ...
    any(any((mod(x,1) == 0))) && any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, xIntegralAMin, xIntegralAMax, ColorFace, Ipoints, Smatrix);


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

set(gca, 'FontSize', 14)
grid on;
hold off;

end