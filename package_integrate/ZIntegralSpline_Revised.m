function yIntegralSpline = ZIntegralSpline_Revised(xData, yData, xIntegralSpline, varargin)
%% Generalized numerical integration
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X), this function returns the value of the integral of the f 
% function with the upper and lower limits of integration xmin and 
% xmax respectively. The integration is performed with a 
% pseudo-order of accuracy Psacc, i.e. the integration is 
% accurate if the f function is a polynomial of the degree of 
% Psacc or less. The integration can either be visualized in the 
% figure figure(figr) if figr is a natural number or not if figr is "0". 
% 
%% Variables
% 
% This function has the form of 
% ZIntegA = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr)
% 
% xData and yData are the vectors of the aforementioned values 
% xData(i) and yData(i), respectively, of the independent variable 
% X and of the dependent variable Y, respectively, of an arbitrary 
% function Y = f(X) (yData(i) = f(xData(i)). xData and yData both 
% have to be column vectors of real numbers of equal length. 
% xData vector does not have to be sorted (i.e. it is not required 
% that xData(i) > xData(j) for every i > j). 
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval. 
% 
% Psacc is the pseudo-order of accuracy of the integration, i.e. 
% the integration is accurate if the f function is a polynomial of 
% the degree of Psacc or less. It has to be an integer contained 
% in the interval [0, length(x) – 1]. 
% 
% mode is the selected mode of integration. 
%       If mode == 0, the basic mode of integration will be 
%       performed (see “Pseudo-order of accuracy integration 
%       principle” for further details). 
%       If mode == 1, an augmented mode of the basic mode of 
%       integration will be performed. In this mode, the limits of I(k) 
%       intervals (see “Pseudo-order of accuracy integration 
%       principle” for further details) are augmented so that 
%       Lagrange polynomial extrapolation is averted for every I(k) 
%       possible. 
%       If mode == 2, an augmented mode of the basic mode of 
%       integration will be performed. In this mode, the limits of I(k) 
%       intervals (see “Pseudo-order of accuracy integration 
%       principle” for further details) are augmented so that not 
%       more than 1 + half of x(i) values of the S(k) set are higher 
%       or lower than the limits of I(k) for every I(k) interval 
%       possible. 
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. If figr == 0, the 
% integration will not be visualized. 
% 
% ZIntegA is the output of the ZIntegralA function and it is the 
% numerical integral of the f function with the limits of integration 
% xmin and xmax with the pseudo-order of accuracy Psacc. 
% 
%% Pseudo-order of accuracy integration principle
% 
% This function uses the GetPointsZIntegralA0 function to divide 
% the X axis into several intervals I(k). In every I(k) interval, there 
% is a set S(k) of Psacc + 1 x(i) values. For each point P in the 
% interval I(k), the x(i) values of S(k) are the closest Psacc + 1 
% x(i) values to the P point. In each I(k) interval, the f function is 
% approximated by the Lagrange polynomial p(k) which is based 
% on {(x(i), y(i)) | x(i) is in S(k)}. This approximation of the function 
% f is then integrated with the limits of integration xmin and xmax. 
% With the GetPointsZIntegralA1 function and the 
% GetPointsZIntegralA2 function, the limits of I(k) intervals are 
% further augmented. See the description of the two functions 
% for further details. 


%     In the following lines, the x and y values are sorted.

pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppData = mkpp(breaks, coefs);
coefsLength = length(coefs);
coefsInteg = [times(coefs, repmat([1/4, 1/3, 1/2, 1], coefsLength, 1)), zeros(coefsLength,1)];


%     In the following lines, the xmin and xmax values are set so 
%     that xmax > xmin. To account for the case of xmax < xmin, 
%     the final result will be multiplied by the integer 
%     BoundaryOrder. BoundaryOrder integer serves as the 
%     indicator of whether the input xmax < xmin or not, and is 
%     assigned the value “-1” in the former case and the value “1” 
%     in the latter case. BoundaryOrder integer is also used to 
%     assign the proper color scheme to the optional visualization 
%     of the integration. 

breaksReal = breaks;
breaksReal(1) = - inf; 
breaksReal(end) = inf;

BoundaryOrder = 1;

%     In the following lines, if 0 ~= 0, the numerical integration is 
%     visualized by the use of the DrawZIntegA function.

if length(varargin) == 1
    DrawZIntegA(xData, yData, ppData, min(xIntegralSpline), max(xIntegralSpline), BoundaryOrder, varargin{1});
end

%     Finally, the integral is calculated by summing the appropriate 
%     integrals of the approximation of f function over each 
%     interval. The appropriate integrals over each interval are the 
%     integrals over all intervals between intervals in which xmin 
%     and xmax are located and the integrals of parts of the 
%     intervals in which xmin and/or xmax are located.

j = 2;
a = 1;

xIntegralSplineLength = length(xIntegralSpline);
yIntegralSpline = zeros(xIntegralSplineLength, 1);

while breaksReal(j) <= xIntegralSpline(1)
    j = j +1;
end

ppIntegralSpline = mkpp([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));

Summa = 0;

for b = 2 : xIntegralSplineLength
    if xIntegralSpline(b) >= breaksReal(j)
        yIntegralSpline(a : b - 1) = Summa + ppval(ppIntegralSpline, xIntegralSpline(a : b - 1)) - ppval(ppIntegralSpline, xIntegralSpline(a));
        Summa = yIntegralSpline(b - 1) + ppval(ppIntegralSpline, breaks(j)) - ppval(ppIntegralSpline, xIntegralSpline(b - 1));
        j = j + 1;
        while breaksReal(j) <= xIntegralSpline(b)
            ppIntegralSpline = mkpp([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));
            Summa = Summa + ppval(ppIntegralSpline, breaks(j)) - ppval(ppIntegralSpline, breaks(j - 1));
            j = j +1;
        end
        a = b;
        ppIntegralSpline = mkpp([breaks(j - 1); breaks(j)], coefsInteg(j - 1, :));
    end
end

yIntegralSpline(a : end) = Summa + ppval(ppIntegralSpline, xIntegralSpline(a : end)) - ppval(ppIntegralSpline, max(breaks(j - 1), xIntegralSpline(max(a - 1, 1))));

%     In the following line, if the input xmax < xmin, ZIntegA is 
%     multiplied by "-1".

yIntegralSpline = yIntegralSpline * BoundaryOrder;

end

function DrawZIntegA(x, y, ppData, xmin, xmax, BoundaryOrder, figr)
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
% BoundaryOrder is the indicator of whether the original input 
% xmax < xmin or not, and has the value “-1” in the former case 
% and the value “1” in the latter case. 
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. 
 

%     N represents the number of points with which each section 
%     of the approximation of the function and the integral will be 
%     plotted. 

N = 1000;

figure(figr)
clf;
hold on;

if BoundaryOrder == 1
    ColorFace = [0, 0, 1];
else
    ColorFace = [1, 0, 0];
end

%     The following lines contain three sections, each separated 
%     from the next by an empty line. They deal with the X values 
%     lower than Ipoints(2) (first section), higher than 
%     Ipoints(end - 1) (third section) and the intermediary values 
%     (second section), respectively. In each section, the vector 
%     of coefficients p of the appropriate Lagrange polynomial is 
%     calculated. Then the Lagrange polynomial is plotted over an 
%     appropriate interval. Finally, the area under the curve which 
%     represents the integral is plotted. 


X = (linspace(xmin, xmax, N))';
Y = ppval(ppData, X);
h = area(X, Y);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

X = (linspace(min(min(x), xmin), max(max(x), xmax), N))';
Y = ppval(ppData, X);
plot(X, Y, 'r', 'LineWidth', 1.2);

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(x, y, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end