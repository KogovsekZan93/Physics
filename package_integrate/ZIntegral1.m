function ZInteg1 = ZIntegral1(x, y, xmin, xmax, Psacc, figr)
%% Generalized numerical integration
% 
% Author: Žan Kogovšek
% Date: 6.5.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X), this function returns the value of the integral of the 
%  function f with the upper and lower limits of integration xmin 
% and xmax respectively. The integration is performed with a 
% pseudo-order of accuracy Psacc, i.e. the integration is 
% accurate if f is a polynomial of the degree of Psacc of less. 
% The integration can either be visualized in the figure figure(figr) 
% if figr is a natural number or not if figr is zero. 
% 
%% Variables
% 
% This function has the form of 
% ZInteg1 = ZIntegral1(x, y, xmin, xmax, Psacc, figr)
% 
% x and y are vectors of aforementioned values x(i) and y(i), 
% respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors of 
% real numbers of equal length. x vector does not have to be 
% sorted (i.e. it is not required that x(i) > x(j) for every i > j).
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval.
% 
% Psacc is the pseudo-order of accuracy of the integration, i.e. 
% the integration is accurate if f is a polynomial of the degree of 
% Psacc of less. It has to be an integer contained in the interval 
% [0, length(x) – 1].
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. If figr = 0, the 
% integration will not be visualized.
% 
% ZInteg1 is the output of the ZIntegral1 function and it is the 
% numerical integral of the function f with the limits of integration 
% xmin and xmax with the pseudo-order of accuracy Psacc.
%
%% Pseudo-order of accuracy integration principle
% 
% This function uses the GetPointsZIntegral1 function to divide 
% the X axis into several intervals I(k). In every I(k) interval there 
% is a set S(k) of Psacc + 1 x(i) values. For each point P in the 
% interval I(k), the x(i) values of S(k) are the closest Psacc + 1 
% x(i) values to the P point. In each interval I(k) the f function is 
% approximated by the Lagrange polynomial p(k) which is based 
% on {(x(i), y(i)) | x(i) is in S(k)}. This approximation of the function 
% f is then integrated with the limits of integration xmin and xmax.


%     In the following lines, the x and y values are sorted.

[x, I] = sort(x);
y = y(I);

%     In the following lines, the xmin and xmax values are set so 
%     that xmax > xmin. If the input xmax < xmin, ZInteg1, i.e. the 
%     output value, will be multiplied by -1 (BoundaryOrder). 
%     See Line 137.

BoundaryOrder = 1;
if xmax < xmin
    [xmax, xmin] = deal(xmin, xmax);
    BoundaryOrder = -1;
end

%     In the following line, the borders for the intervals I(k) are 
%     calculated and given in the vector Ipoints together with the 
%     corresponding S(k) sets, each of which is represented by 
%     the corresponding row in the matrix Smatrix, e.i. the x(i) 
%     values in Smatrix(k, :) (= S(k)) are the closest Psacc + 1 x(i) 
%     values to each P point in the interval 
%     [Ipoints(k), Ipoints(k + 1)]. For more details see the 
%     GetPointsZIntegral1 function documentation.

[Ipoints, Smatrix] = GetPointsZIntegral1(x, Psacc + 1);

%     In the following lines the intervals I(k) in which xmin and 
%     xmax are located (represented by k indices zonemin and 
%     zonemax, respectively) are found. 

len_Ipoints = length(Ipoints);
zonemin = len_Ipoints;
zonemax = len_Ipoints;

for i = 1 : len_Ipoints
    if Ipoints(i) > xmin
        zonemin = max(i - 1, 1);
        break;
    end
end

for i = 1 : len_Ipoints
    if Ipoints(i) >= xmax
        zonemax = max(i - 1, 1);
        break;
    end
end

%     In the following lines, the numerical integration is visualized 
%     by the use of the DrawZInteg1 function.

if figr ~= 0
    DrawZInteg1(x, y, Ipoints, Smatrix, xmin, xmax, figr);
end

%     Finally, the integral is calculated by summing the appropriate 
%     integrals of the approximation of f function over each 
%     interval. The appropriate integrals over each interval are the 
%     integrals over all intervals between intervals in which xmin 
%     and xmax are located and the integrals of parts of the 
%     intervals in which xmin and/or xmax are located.

if zonemin == zonemax
    ZInteg1 = SubZIntegral1(x(Smatrix(zonemin, :)), y(Smatrix(zonemin, :)), xmin, xmax);
else
    ZInteg1 = SubZIntegral1(x(Smatrix(zonemin, :)), y(Smatrix(zonemin, :)), xmin, Ipoints(zonemin + 1)) + SubZIntegral1(x(Smatrix(zonemax, :)), y(Smatrix(zonemax, :)), Ipoints(zonemax), xmax);
    if zonemax-1 ~= zonemin
        for i = 1 : zonemax - zonemin - 1
            ZInteg1 = ZInteg1 + SubZIntegral1(x(Smatrix(zonemax - i, :)), y(Smatrix(zonemax - i, :)), Ipoints(zonemax - i), Ipoints(zonemax - i + 1));
        end
    end
end

%     In the following line, if the input xmax < xmin, ZInteg1 is 
%     multiplied by -1.

ZInteg1 = ZInteg1 * BoundaryOrder;

end

function [Ipoints, Smatrix] = GetPointsZIntegral1(x, n)
%% Border points of intervals calculation
% 
% Author: Žan Kogovšek
% Date: 6.5.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n x(i) values for 
% each I(k) interval such that for each point P in the I(k) interval 
% the x(i) values of the S(k) set are the closest n x(i) values to the 
% P point. The borders of the I(k) intervals are represented by 
% the vector Ipoints and the sets S(k) are represented by the 
% matrix Smatrix.
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZIntegral1(x, n)
% 
% x is a vector of aforementioned values x(i) of the independent 
% variable X. x has to be a column vector of real numbers and 
% has to be sorted (i.e. it is required for x(i) > x(j) for every i > j).
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector the same n x(i) values (they are given in the k-th 
% row of the Smatrix matrix) are the closest n x(i) values to any 
% point in the I(k) interval.
% 
% Ipoints is a column vector. Each interval I(k) is [Ipoints(k), 
% Ipoints(k + 1)] except for the first interval, which is 
% (-inf, Ipoints(2)], and the last interval, which is 
% [Ipoints(end), inf). 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% the values of the closest n x(i) values to every P point in I(k) 
% interval.

len = length(x);

Ipoints = zeros(len - n + 1,1);
Ipoints(1, 1) = x(1);
Ipoints(2 : len - n + 1, 1) = (x(1 : len - n) + x(n + 1 : len)) / 2;

Smatrix = zeros(len - n + 1, n);
for i = 1 : len - n + 1
    Smatrix(i, 1 : n) = (1 : n) + i - 1;
end

end

function DrawZInteg1(x, y, Ipoints,  Smatrix, xmin, xmax, figr)
%% Visualization of numerical integration with ZIntegral1
% 
% Author: Žan Kogovšek
% Date: 6.5.2020
% 
%% Description
% 
% Using this function, the visualization of the numerical 
% integration with ZIntegral1 is plotted in the figure figure(figr). 
% The input values values x(i) of the independent variable X and 
% the values y(i) of the dependent variable Y of an arbitrary 
% function Y = f(X) are plotted as blue circles (i.e. (x(i),y(i)) 
% points), the approximation of the f function is plotted as a red 
% line and the integral is plotted as the semi-transparent blue 
% area under the red curve. 
% 
%% Variables
% 
% This function has the form of 
% DrawZInteg1(x, y, Ipoints, Smatrix, xmin, xmax, figr)
% 
% x and y are vectors of aforementioned values x(i) and y(i), 
% respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors of 
% real numbers of equal length. x vector does not have to be 
% sorted (i.e. it is not required for x(i) > x(j) for every i > j).
% 
% Ipoints is a column vector and Smatrix is a matrix. For each 
% interval [Ipoints(I), Ipoints(I+1)], the plotted approximation of 
% the f function will be the Lagrange polynomial which is based 
% on the set {(x(i), y(i)) | x(i) is in Smatrix(:, I)}. For X < Ipoints(1) 
% the Lagrange polynomial which is the approximation of the f 
% function is based on the set {(x(i), y(i)) | x(i) is in Smatrix(:, 1)} 
% and for X > Ipoints(end) the Lagrange polynomial which is the 
% approximation of the f function is based on the set 
% {(x(i), y(i)) | x(i) is in Smatrix(:, end)}.
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval.
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

l = length(Ipoints);

%     The following lines contain three sections, each separated 
%     from the next by an empty line. They deal with the X values 
%     lower than Ipoints(1) (first section), higher than Ipoints(end) 
%     (third section) and the intermediary values (second section), 
%     respectively. In each section, the vector of coefficients p of 
%     the appropriate Lagrange polynomial is calculated. Then the 
%     Lagrange polynomial is plotted over an appropriate interval.
%     Finally, the area under the curve, which represents the 
%     integral is plotted. 


xx = x(Smatrix(1, :));
yy = y(Smatrix(1, :));
n = length(xx);
A = ones(n, n);
for j = 2 : n
    A(:,j) = power(xx, j - 1);
end
a = linsolve(A, yy);
p = flipud(a);
if xmin < Ipoints(min(2,l))
    X = (linspace(xmin, min(xmax, Ipoints(min(2,l))), N))';
    Y = polyval(p, X);
    h = area(X, Y);
    h.FaceColor = [0, 0, 1];
    h.FaceAlpha = 0.3;
end
X = (linspace(min(Ipoints(1), xmin), Ipoints(min(2,l)), N))';
Y = polyval(p, X);
plot(X, Y, 'r', 'LineWidth', 1.2);

for i = 2 : l - 1
    xx = x(Smatrix(i, :));
    yy = y(Smatrix(i, :));
    n = length(xx);
    A = ones(n, n);
    for j = 2 : n
        A(:, j) = power(xx, j - 1);
    end
    a = linsolve(A, yy);
    p = flipud(a);
    if xmin > Ipoints(i) && xmin < Ipoints(i + 1)
        X = (linspace(xmin, min(xmax, Ipoints(i + 1)), N))';
        Y = polyval(p, X);
        h = area(X, Y);
        h.FaceColor = [0, 0, 1];
        h.FaceAlpha = 0.3;
    else
        if xmin < Ipoints(i) && xmax > Ipoints(i)
            X = (linspace(Ipoints(i), min(Ipoints(i + 1), xmax), N))';
            Y = polyval(p, X);
            h = area(X, Y);
            h.FaceColor = [0, 0, 1];
            h.FaceAlpha = 0.3;
        end
    end    
    X = (linspace(Ipoints(i), Ipoints(i + 1), N))';
    Y = polyval(p, X);
    plot(X, Y, 'r','LineWidth', 1.2);
end

xx = x(Smatrix(l, :));
yy = y(Smatrix(l, :));
n = length(xx);
A = ones(n, n);
for j = 2 : n
    A(:, j) = power(xx, j - 1);
end
a = linsolve(A, yy);
p = flipud(a);
if xmax > Ipoints(l)
    X = (linspace(max(xmin, Ipoints(l)), xmax, N))';
    Y = polyval(p, X);
    h = area(X, Y);
    h.FaceColor = [0, 0, 1];
    h.FaceAlpha = 0.3;
end
X = (linspace(Ipoints(l), max(max(x), xmax), N))';
Y = polyval(p, X);
plot(X, Y, 'r', 'LineWidth', 1.2);

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(x, y, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end

function SubZInteg1 = SubZIntegral1(x, y, xmin, xmax)
%% Description
%% Integration of the Lagrange polynomial
% 
% Author: Žan Kogovšek
% Date: 6.5.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X), this function returns the value of the integral of the 
% Lagrange polynomial p, which is based on the set 
% {(x(i), y(i)) | x(i) is in x} with the upper and lower limits of 
% integration xmin and xmax respectively.
% 
%% Variables
% 
% This function has the form of 
% ZInteg1 = SubZIntegral1(x, y, xmin, xmax).
% 
% x and y are vectors of aforementioned values x(i) and y(i), 
% respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors of 
% real numbers of equal length. x needs to be sorted (i.e. it is 
% required that x(i) > x(j) for every i > j).
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration of the p Lagrange polynomial, which is based on 
% the set {(x(i), y(i)) | x(i) is in x} (i.e. (p(x(i)) = y(i) = f(x(i)))). The 
% limits do not have to be contained in the [min(x), max(x)] 
% interval.
%
% SubZInteg1 is the output of the SubZIntegral1 function and it 
% is the value of the integral of p(x) Lagrange polynomial with the 
% upper and lower limits of integration xmin and xmax 
% respectively.

%     In the following lines, the vector of coefficients a for the 
%     Lagrange polynomial is calculated.  

n = length(x);
A = ones(n, n);

for i = 2 : n
    A(:, i) = power(x, i - 1);
end

a = linsolve(A, y);

%     In the following lines, the coefficients in a vector of 
%     coefficients are modified so that they represent the 
%     coefficients of the polynomial which is the integral of the p 
%     Lagrange polynomial.

for i = 1 : n
    a(i) = a(i) / i;
end

a = [0; a];

%     Because coefficients in vector of coefficients a are in the 
%     form [a0; a1; ... ; an - 2; an - 1] and the polyval function 
%     requires the reverse order of polynomial coefficients, the 
%     values are flipped. 

p = flipud(a);

SubZInteg1 = polyval(p, xmax) - polyval(p, xmin);

end
