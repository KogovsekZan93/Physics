function yDeriv = ZDerivativeA(xData, yData, ordDeriv, acc, xDeriv, figr, mode)
%% Generalized numerical integration
% 
% Author: Žan Kogovšek
% Date: 15.7.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X), this function returns the value of the integral of the 
%  function f with the upper and lower limits of integration xmin 
% and xmax respectively. The integration is performed with a 
% pseudo-order of accuracy Acc, i.e. the integration is 
% accurate if f is a polynomial of the degree of Acc of less. 
% The integration can either be visualized in the figure figure(figr) 
% if figr is a natural number or not if figr is "0". 
% 
%% Variables
% 
% This function has the form of 
% ZIntegA = ZIntegralA(x, y, xmin, xmax, Acc, figr, mode)
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
% Acc is the pseudo-order of accuracy of the integration, i.e. 
% the integration is accurate if f is a polynomial of the degree of 
% Acc of less. It has to be an integer contained in the interval 
% [0, length(x) – 1].
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. If figr == 0, the 
% integration will not be visualized.
% 
% ZIntegA is the output of the ZIntegralA function and it is the 
% numerical integral of the function f with the limits of integration 
% xmin and xmax with the pseudo-order of accuracy Acc.
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
%       more than 1 + half of x(k, l) values of the S(k) set are 
%       higher or lower than the limits of I(k) for every I(k) interval 
%       possible. 
% 
%% Pseudo-order of accuracy integration principle
% 
% This function uses the GetPointsZIntegralA0 function to divide 
% the X axis into several intervals I(k). In every I(k) interval, there 
% is a set S(k) of Acc + 1 x(k, l) values. For each point P in the 
% interval I(k), the x(i, k) values of S(k) are the closest Acc + 1 
% x(i) values to the P point. In each I(k) interval, the f function is 
% approximated by the Lagrange polynomial p(k) which is based 
% on {(x(i), y(i)) | x(i) is in S(k)}. This approximation of the function 
% f is then integrated with the limits of integration xmin and xmax. 
% With the GetPointsZIntegralA1 function and the 
% GetPointsZIntegralA2 function, the limits of I(k) intervals are 
% further augmented. See the description of the two functions 
% for further details. 


%     In the following lines, the x and y values are sorted.

[xData, I] = sort(xData);
yData = yData(I);

%     In the following lines, the xmin and xmax values are set so 
%     that xmax > xmin. To account for the case of xmax < xmin, 
%     the final result will be multiplied by the integer 
%     BoundaryOrder. BoundaryOrder integer serves as the 
%     indicator of whether the input xmax < xmin or not, and is 
%     assigned the value “-1” in the former case and the value “1” 
%     in the latter case. BoundaryOrder integer is also used to 
%     assign the proper color scheme to the optional visualization 
%     of the integration. 

%     In the following line, the borders for the intervals I(k) are 
%     calculated and given in the vector Ipoints together with the 
%     corresponding S(k) sets, each of which is represented by 
%     the corresponding row in the matrix Smatrix, e.i. the x(k, l) 
%     values in Smatrix(k, :) (= S(k)) are the closest Acc + 1 x(i) 
%     values to each P point in the interval 
%     [Ipoints(k), Ipoints(k + 1)]. For more details see the 
%     GetPointsZIntegralA0 function documentation. 
%     If mode ~=0, the limits of I(k) are further augmented by 
%     either the GetPointsZIntegralA1 function (i.e. if mode == 1) 
%     or the GetPointsZIntegralA2 function (i.e. if mode == 2). 

npoints = acc + ordDeriv;

if mode == 0
    [Ipoints, Smatrix] = GetPointsZIntegralA0(xData, npoints);
else
    if mode == 1
        [Ipoints, Smatrix] = GetPointsZIntegralA1(xData, npoints);
    else
        if mode == 2
            [Ipoints, Smatrix] = GetPointsZIntegralA2(xData, npoints);
        end
    end
end

%     In the following lines the intervals I(k) in which xmin and 
%     xmax are located (represented by k indices zonemin and 
%     zonemax, respectively) are found. 

[pMatrix, pDerivMatrix] = GetLagrangePolynomialMatrix(xData, yData, Smatrix,ordDeriv);

%     In the following lines, if 0 ~= 0, the numerical integration is 
%     visualized by the use of the DrawZIntegA function.

if figr ~= 0
    DrawZIntegA(xData, yData, Ipoints,  pMatrix, figr, min(xDeriv), max(xDeriv));
end

%     Finally, the integral is calculated by summing the appropriate 
%     integrals of the approximation of f function over each 
%     interval. The appropriate integrals over each interval are the 
%     integrals over all intervals between intervals in which xmin 
%     and xmax are located and the integrals of parts of the 
%     intervals in which xmin and/or xmax are located.

len_Ipoints = length(Ipoints);

len_xDeriv = length(xDeriv);
yDeriv=zeros(len_xDeriv, 1);

k = 2;

for i = 1 : len_xDeriv
    for j = k : len_Ipoints
        if Ipoints(j) >= xDeriv(i)
            zone = j - 1;
            k = j;
            break;
        end
    end
yDeriv(i) = polyval(pDerivMatrix(:, zone), xDeriv(i));
end

end

function [Ipoints, Smatrix] = GetPointsZIntegralA0(x, n)
%% Basic border points of intervals I(k) calculation
% 
% Author: Žan Kogovšek
% Date: 15.7.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n x(k, l) values 
% for each I(k) interval such that for each point P in the I(k) 
% interval the x(k, l) values of the S(k) set are the closest n x(i) 
% values to the P point. The borders of the I(k) intervals are 
% represented by the vector Ipoints and the sets S(k) are 
% represented by the matrix Smatrix.
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZIntegralA0(x, n)
% 
% x is a vector of aforementioned values x(i) of the independent 
% variable X. x has to be a column vector of real numbers and 
% has to be sorted (i.e. it is required for x(i) > x(j) for every i > j).
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector the same n x(k, l) values (they are given in the 
% k-th row of the Smatrix matrix) are the closest n x(i) values to 
% any point in the I(k) interval.
% 
% Ipoints is a column vector. Each interval I(k) is 
% [Ipoints(k), Ipoints(k + 1)].
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% the values of the closest n x(k, l) values to every P point in I(k) 
% interval.


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
% Date: 15.7.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n x(k, l) values 
% for each I(k) interval such that for each point P in the I(k) 
% interval, the x(k, l) values of the S(k) set are the closest n x(i) 
% values to the P point. The I(k) intervals can be further 
% augmented so that for each I(k) interval (except for the I(k) 
% intervals at least one of the limits of which is either inf or -inf) 
% the I(k) interval is contained in the [min(x(k, l)), max(x(k, l))]. 
% This way, extrapolation of the Lagrange polynomials in the 
% numerical integration is prevented all possible I(k) intervals. 
% The borders of the augmented I(k) intervals are represented 
% by the vector Ipoints and the sets S(k) are represented by the 
% matrix Smatrix.
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZIntegralA1(x, n)
% 
% x is a vector of aforementioned values x(i) of the independent 
% variable X. x has to be a column vector of real numbers and 
% has to be sorted (i.e. it is required for x(i) > x(j) for every i > j). 
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector the same n x(i) values (they are given in the k-th 
% row of the Smatrix matrix) are the closest n x(i) values to any 
% point in the I(k) interval with the constraint that every I(k) 
% interval (except for the I(k) intervals at least one of the limits of 
% which is either inf or -inf) has to be contained in the interval 
%  [min(x(k, l)), max(x(k, l))]. 
% 
% Ipoints is a column vector. Each interval I(k) is 
% [Ipoints(k), Ipoints(k + 1)]. 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% the values of the closest n x(i) values to every P point in I(k) 
% interval with the constraint that every I(k) interval (except for the 
% I(k) intervals at least one of the limits of which is either inf or 
% -inf) has to be contained in the interval 
% [min(x(k, l)), max(x(k, l))]. 

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
% Date: 15.7.2020
% 
%% Description
% 
% Given the values x(i) of the independent variable X and a 
% natural number n, this function returns the vector Ipoints and 
% the matrix Smatrix. The X variable can be divided into intervals 
% I(k) in such a way that there exists a set S(k) of n x(k, l) values 
% for each I(k) interval such that for each point P in the I(k) 
% interval, the x(i) values of the S(k) set are the closest n x(i) 
% values to the P point. The I(k) intervals can be further 
% augmented so that for each I(k) interval (except for the I(k) 
% intervals at least one of the limits of which is either inf or -inf) 
% the I(k) interval is contained in the interval between the middle 
% two (if n is even) or middle three (if n is odd) x(k, l) points. This 
% way, the Lagrange polynomials are integrated over parts of 
% such I(k) intervals, over which the approximation of the f 
% function may have the greatest fidelity. The borders of the 
% augmented I(k) intervals are represented by the vector Ipoints 
% and the sets S(k) are represented by the matrix Smatrix.
%  
%% Variables
% 
% This function has the form of 
% [Ipoints, Smatrix] = GetPointsZIntegralA2(x, n)
% 
% x is a vector of aforementioned values x(i) of the independent 
% variable X. x has to be a column vector of real numbers and 
% has to be sorted (i.e. it is required for x(i) > x(j) for every i > j).
% 
% n is a natural number. In each interval I(k), represented by the 
% Ipoints vector the same n x(i) values (they are given in the k-th 
% row of the Smatrix matrix) are the closest n x(i) values to any 
% point in the I(k) interval with the constraint that every I(k) 
% interval (except for the I(k) intervals at least one of the limits of 
% which is either inf or -inf) has to be contained in the interval 
% between the middle two (if n is even) or middle three 
% (if n is odd) x(k, l) points. 
% 
% Ipoints is a column vector. Each interval I(k) is 
% [Ipoints(k), Ipoints(k + 1)]. 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% the values of the closest n x(i) values to every P point in I(k) 
% interval with the constraint that every I(k) interval (except for the 
% I(k) intervals at least one of the limits of which is either inf or 
% -inf) has to be contained in the interval between the middle two 
% (if n is even) or middle three (if n is odd) x(k, l) points. 


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

function [p, pDeriv] = GetLagrangePolynomial(x, y, ordDeriv)
%% Visualization of numerical integration with ZIntegralA
% 
% Author: Žan Kogovšek
% Date: 15.7.2020
% 
%% Description
% 
% Using this function, the visualization of the numerical 

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

p = flipud(a);

for i = ordDeriv + 1 : n
    a(i) = a(i) * factorial(i - 1) / factorial(i - 1 - ordDeriv);
end

a = a(ordDeriv + 1 : end);

pDeriv = flipud(a);

end

function [pMatrix, pDerivMatrix] = GetLagrangePolynomialMatrix(xData, yData, Smatrix,ordDeriv)
nIInter = length(Smatrix(:, 1));
npoints = length(Smatrix(1, :));
pMatrix = zeros(npoints, nIInter);
pDerivMatrix = zeros(npoints - ordDeriv, nIInter);

for i = 1 : nIInter
    [pMatrix(:, i), pDerivMatrix(:, i)] = GetLagrangePolynomial(xData(Smatrix(i, :)), yData(Smatrix(i, :)), ordDeriv);
end

end

function DrawZIntegA(x, y, Ipoints,  pMatrix, figr, xmin, xmax)
%% Visualization of numerical integration with ZIntegralA
% 
% Author: Žan Kogovšek
% Date: 15.7.2020
% 
%% Description
% 
% Using this function, the visualization of the numerical 
% integration with ZIntegralA is plotted in the figure figure(figr). 
% The input values values x(i) of the independent variable X and 
% the values y(i) of the dependent variable Y of an arbitrary 
% function Y = f(X) are plotted as blue circles (i.e. (x(i),y(i)) 
% points), the approximation of the f function is plotted as a red 
% line and the integral is plotted as the semi-transparent area 
% under the red curve. The semi-transparent area is blue if the 
% original upper limit of integration has a higher value than the 
% original lower limit of integration, and is red if that is not the 
% case. 
%
% 
%% Variables
% 
% This function has the form of 
% DrawZIntegA(x, y, Ipoints, Smatrix, xmin, xmax, figr)
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

%     The following lines contain three sections, each separated 
%     from the next by an empty line. They deal with the X values 
%     lower than Ipoints(2) (first section), higher than 
%     Ipoints(end - 1) (third section) and the intermediary values 
%     (second section), respectively. In each section, the vector 
%     of coefficients p of the appropriate Lagrange polynomial is 
%     calculated. Then the Lagrange polynomial is plotted over an 
%     appropriate interval. Finally, the area under the curve which 
%     represents the integral is plotted. 

X = (linspace(min(min(x), xmin), Ipoints(2), N))';
Y = polyval(pMatrix(:, 1), X);
plot(X, Y, 'r', 'LineWidth', 1.2);

for i = 2 : len_Ipoints - 2
    X = (linspace(Ipoints(i), Ipoints(i + 1), N))';
    Y = polyval(pMatrix(:, i), X);
    plot(X, Y, 'r','LineWidth', 1.2);
end

if len_Ipoints ~= 2
    X = (linspace(Ipoints(len_Ipoints-1), max(max(x), xmax), N))';
    Y = polyval(pMatrix(:, end), X);
    plot(X, Y, 'r', 'LineWidth', 1.2);
end

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(x, y, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end
