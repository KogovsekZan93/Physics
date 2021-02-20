function ZIntegA = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr)
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

[x, I] = sort(x);
y = y(I);

%     In the following lines, the xmin and xmax values are set so 
%     that xmax > xmin. To account for the case of xmax < xmin, 
%     the final result will be multiplied by the integer 
%     BoundaryOrder. BoundaryOrder integer serves as the 
%     indicator of whether the input xmax < xmin or not, and is 
%     assigned the value “-1” in the former case and the value “1” 
%     in the latter case. BoundaryOrder integer is also used to 
%     assign the proper color scheme to the optional visualization 
%     of the integration. 

BoundaryOrder = 1;
if xmax < xmin
    [xmax, xmin] = deal(xmin, xmax);
    BoundaryOrder = -1;
end

%     If Psacc == 0, the basic mode of integration is the only 
%     sensible one. 

if Psacc == 0
    mode = 0;
end

%     In the following line, the borders for the intervals I(k) are 
%     calculated and given in the vector Ipoints together with the 
%     corresponding S(k) sets, each of which is represented by 
%     the corresponding row in the matrix Smatrix, e.i. the 
%     x(Smatrix(k, :)) values are the closest Psacc + 1 x(i) values 
%     to each P point in the interval [Ipoints(k), Ipoints(k + 1)]. 
%     For more details see the GetPointsZIntegralA0 function 
%     documentation. If mode ~=0, the limits of I(k) are further 
%     augmented by either the GetPointsZIntegralA1 function 
%     (i.e. if mode == 1) or the GetPointsZIntegralA2 function 
%     (i.e. if mode == 2). 

if mode == 0
    [Ipoints, Smatrix] = GetPointsZIntegralA0(x, Psacc + 1);
else
    if mode == 1
        [Ipoints, Smatrix] = GetPointsZIntegralA1(x, Psacc + 1);
    else
        if mode == 2
            [Ipoints, Smatrix] = GetPointsZIntegralA2(x, Psacc + 1);
        end
    end
end

%     In the following lines the intervals I(k) in which xmin and 
%     xmax are located (represented by k indices zonemin and 
%     zonemax, respectively) are found. 

len_Ipoints = length(Ipoints);

for i = 2 : len_Ipoints
    if Ipoints(i) > xmin
        zonemin = i - 1;
        break;
    end
end

for i = 2 : len_Ipoints
    if Ipoints(i) >= xmax
        zonemax = i - 1;
        break;
    end
end

%     In the following lines, if 0 ~= 0, the numerical integration is 
%     visualized by the use of the DrawZIntegA function.

if figr ~= 0
    DrawZIntegA(x, y, Ipoints, Smatrix, xmin, xmax, BoundaryOrder, figr);
end

%     Finally, the integral is calculated by summing the appropriate 
%     integrals of the approximation of f function over each 
%     interval. The appropriate integrals over each interval are the 
%     integrals over all intervals between intervals in which xmin 
%     and xmax are located and the integrals of parts of the 
%     intervals in which xmin and/or xmax are located.

if zonemin == zonemax
    ZIntegA = SubZIntegralA(x(Smatrix(zonemin, :)), y(Smatrix(zonemin, :)), xmin, xmax);
else
    ZIntegA = SubZIntegralA(x(Smatrix(zonemin, :)), y(Smatrix(zonemin, :)), xmin, Ipoints(zonemin + 1)) + SubZIntegralA(x(Smatrix(zonemax, :)), y(Smatrix(zonemax, :)), Ipoints(zonemax), xmax);
    if zonemax-1 ~= zonemin
        for i = 1 : zonemax - zonemin - 1
            ZIntegA = ZIntegA + SubZIntegralA(x(Smatrix(zonemax - i, :)), y(Smatrix(zonemax - i, :)), Ipoints(zonemax - i), Ipoints(zonemax - i + 1));
        end
    end
end

%     In the following line, if the input xmax < xmin, ZIntegA is 
%     multiplied by "-1".

ZIntegA = ZIntegA * BoundaryOrder;

end

function [Ipoints, Smatrix] = GetPointsZIntegralA0(x, n)
%% Basic border points of intervals I(k) calculation
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n values of the 
% x vector for each I(k) interval such that for any point P in the 
% I(k) interval, the elements of the S(k) set are the closest n 
% values of the x vector to the P point. The borders of the I(k) 
% intervals are represented by the vector Ipoints and the sets 
% S(k) are represented by the matrix Smatrix. 
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZDerivativeA0(x, n)
% 
% x is the vector of the aforementioned values x(i) of the 
% independent variable X. x has to be a column vector of real 
% numbers and has to be sorted (i.e. it is required for x(i) > x(j) 
% for every i > j). 
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector, the same n values of the x vector (their indices 
% are given in the k-th row of the Smatrix matrix) are the closest 
% n values of the x vector to any point in the I(k) interval. 
% 
% Ipoints is a column vector representing the I(k) intervals. Each 
% interval I(k) is [Ipoints(k), Ipoints(k + 1)]. 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% indices of the closest n values of the x vector to any point in 
% the I(k) interval. 


len = length(x);

Ipoints = zeros(len - n + 2,1);
Ipoints(1) = - inf;
Ipoints(2 : len - n + 1) = (x(1 : len - n) + x(n + 1 : len)) / 2;
Ipoints(len - n + 2) = inf;

Smatrix = zeros(len - n + 1, n);
for i = 1 : len - n + 1
    Smatrix(i, 1 : n) = (1 : n) + i - 1;
end

end

function [Ipoints, Smatrix] = GetPointsZIntegralA1(x, n)
%% First augmented border points of intervals I(k) 
%% calculation
%
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n values of the 
% x vector for each I(k) interval such that for any point P in the 
% I(k) interval, the elements of the S(k) set are the closest n 
% values of the x vector to the P point. The I(k) intervals can be 
% further augmented so that for each I(k) interval (except for the 
% I(k) intervals at least one of the limits of which is either inf or 
% -inf), the I(k) interval is contained in the [min(S(k)), max(S(k))]. 
% This way, extrapolation of the Lagrange polynomials in the 
% numerical integration is prevented for all possible I(k) intervals. 
% The borders of the augmented I(k) intervals are represented 
% by the vector Ipoints and the S(k) sets are represented by the 
% matrix Smatrix. 
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZDerivativeA1(x, n)
% 
% x is the vector of the aforementioned values x(i) of the 
% independent variable X. x has to be a column vector of real 
% numbers and has to be sorted (i.e. it is required for x(i) > x(j) 
% for every i > j). 
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector, the same n values of the x vector (their indices 
% are given in the k-th row of the Smatrix matrix) are the closest 
% n values of the x vector to any point in the I(k) interval with the 
% constraint that every I(k) interval (except for the I(k) intervals at 
% least one of the limits of which is either inf or -inf) has to be 
% contained in the interval 
% [min(x(Smatrix(k, :))), max(x(Smatrix(k, :)))]. 
% 
% Ipoints is a column vector representing the I(k) intervals. Each 
% interval I(k) is [Ipoints(k), Ipoints(k + 1)]. 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% indices of the closest n values of the x vector to any point in 
% the I(k) interval with the constraint that every I(k) interval 
% (except for the I(k) intervals at least one of the limits of which 
% is either inf or -inf) has to be contained in the interval 
% [min(x(Smatrix(k, :))), max(x(Smatrix(k, :)))]. 

len = length(x);

[Ipoints, Smatrix] = GetPointsZIntegralA0(x, n);

for i = 1 : len - n
    if Ipoints(i + 1) > x(Smatrix(i, end))
        Ipoints(i + 1) = x(Smatrix(i, end));
    end
end

for i = 2 : len - n + 1
    if Ipoints(i, 1) < x(Smatrix(i, 1))
        Ipoints(i) = x(Smatrix(i, 1));
    end
end

end

function [Ipoints, Smatrix] = GetPointsZIntegralA2(x, n)
%% Second augmented border points of intervals I(k) 
%% calculation
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n values of the 
% x vector for each I(k) interval such that for any point P in the 
% I(k) interval, the elements of the S(k) set are the closest n 
% values of the x vector to the P point. The I(k) intervals can be 
% further augmented so that for each I(k) interval (except for the 
% I(k) intervals at least one of the limits of which is either inf or 
% -inf) the I(k) interval is contained in the interval between the 
% middle two (if n is even) or middle three (if n is odd) points of 
% S(k). This way, the Lagrange polynomials are integrated only in 
% such I(k) intervals in which the approximation of the f function 
% may have the greatest fidelity. The borders of the augmented 
% I(k) intervals are represented by the vector Ipoints and the S(k) 
% sets are represented by the matrix Smatrix. 
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZDerivativeA2(x, n)
% 
% x is the vector of the aforementioned values x(i) of the 
% independent variable X. x has to be a column vector of real 
% numbers and has to be sorted (i.e. it is required for x(i) > x(j) 
% for every i > j). 
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector, the same n values of the x vector (their indices 
% are given in the k-th row of the Smatrix matrix) are the closest 
% n values of the x vector to any point in the I(k) interval with the 
% constraint that every I(k) interval (except for the I(k) intervals at 
% least one of the limits of which is either inf or -inf) has to be 
% contained in the interval between the middle two (if n is even) 
% or middle three (if n is odd) S(k) elements. 
% 
% Ipoints is a column vector representing the I(k) intervals. Each 
% interval I(k) is [Ipoints(k), Ipoints(k + 1)]. 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% indices of the closest n values of the x vector to any point in 
% the I(k) interval with the constraint that every I(k) interval 
% (except for the I(k) intervals at least one of the limits of which 
% is either inf or -inf) has to be contained in the interval between 
% the middle two (if n is even) or middle three (if n is odd) S(k) 
% points. 


len = length(x);

[Ipoints, Smatrix] = GetPointsZIntegralA0(x, n);

for i = 1 : len - n
    if Ipoints(i + 1) > x(Smatrix(i, floor((n + 3) / 2)))
        Ipoints(i + 1) = x(Smatrix(i, floor((n + 3) / 2)));
    end
end
for i = 2 : len - n + 1
    if Ipoints(i) < x(Smatrix(i, ceil((n - 1) / 2)))
        Ipoints(i) = x(Smatrix(i, ceil((n - 1) / 2)));
    end
end

end

function DrawZIntegA(x, y, Ipoints,  Smatrix, xmin, xmax, BoundaryOrder, figr)
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

len_Ipoints = length(Ipoints);

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

xx = x(Smatrix(1, :));
yy = y(Smatrix(1, :));
n = length(xx);
A = ones(n, n);
for j = 2 : n
    A(:,j) = power(xx, j - 1);
end
a = linsolve(A, yy);
p = flipud(a);
if xmin < Ipoints(2)
    X = (linspace(xmin, min(xmax, Ipoints(2)), N))';
    Y = polyval(p, X);
    h = area(X, Y);
    h.FaceColor = ColorFace;
    h.FaceAlpha = 0.3;
end
X = (linspace(min(min(x), xmin), min(Ipoints(2), max(max(x), xmax)), N))';
Y = polyval(p, X);
plot(X, Y, 'r', 'LineWidth', 1.2);

for i = 2 : len_Ipoints - 2
    xx = x(Smatrix(i, :));
    yy = y(Smatrix(i, :));
    n = length(xx);
    A = ones(n, n);
    for j = 2 : n
        A(:, j) = power(xx, j - 1);
    end
    a = linsolve(A, yy);
    p = flipud(a);
    if xmin >= Ipoints(i) && xmin <= Ipoints(i + 1)
        X = (linspace(xmin, min(xmax, Ipoints(i + 1)), N))';
        Y = polyval(p, X);
        h = area(X, Y);
        h.FaceColor = ColorFace;
        h.FaceAlpha = 0.3;
    else
        if xmin <= Ipoints(i) && xmax >= Ipoints(i)
            X = (linspace(Ipoints(i), min(Ipoints(i + 1), xmax), N))';
            Y = polyval(p, X);
            h = area(X, Y);
            h.FaceColor = ColorFace;
            h.FaceAlpha = 0.3;
        end
    end    
    X = (linspace(Ipoints(i), Ipoints(i + 1), N))';
    Y = polyval(p, X);
    plot(X, Y, 'r','LineWidth', 1.2);
end

if len_Ipoints ~= 2
    xx = x(Smatrix(len_Ipoints - 1, :));
    yy = y(Smatrix(len_Ipoints - 1, :));
    n = length(xx);
    A = ones(n, n);
    for j = 2 : n
        A(:, j) = power(xx, j - 1);
    end
    a = linsolve(A, yy);
    p = flipud(a);
    if xmax > Ipoints(len_Ipoints - 1)
        X = (linspace(max(xmin, Ipoints(len_Ipoints-1)), xmax, N))';
        Y = polyval(p, X);
        h = area(X, Y);
        h.FaceColor = ColorFace;
        h.FaceAlpha = 0.3;
    end
    X = (linspace(Ipoints(len_Ipoints-1), max(max(x), xmax), N))';
    Y = polyval(p, X);
    plot(X, Y, 'r', 'LineWidth', 1.2);
end

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(x, y, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end

function SubZIntegA = SubZIntegralA(x, y, xmin, xmax)
%% Integration of the Lagrange polynomial
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
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
% ZIntegA = SubZIntegralA(x, y, xmin, xmax).
% 
% x and y are the vectors of the aforementioned values x(i) and 
% y(i), respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors 
% of real numbers of equal length. x vector has to be sorted (i.e. 
% it is required that x(i) > x(j) for every i > j). 
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration of the p Lagrange polynomial, which is based on 
% the set {(x(i), y(i)) | x(i) is in x} (i.e. (p(x(i)) = y(i) = f(x(i)))). The 
% limits do not have to be contained in the [min(x), max(x)] 
% interval. 
%
% SubZIntegA is the output of the SubZIntegralA function and it 
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

SubZIntegA = polyval(p, xmax) - polyval(p, xmin);

end
