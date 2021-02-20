function yDeriv = ZDerivativeA(xData, yData, ordDeriv, Acc, xDeriv, figr, mode)
%% Finite difference numerical differentiation
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values xData(i) of the independent variable X and 
% the values yData(i) of the dependent variable Y of an arbitrary 
% function Y = f(X), this function returns the value of the 
% ordDeriv-th derivative of the f function for values xDeriv(i) of 
% the independent variable X. The differentiation is performed 
% with the finite difference method with the order of accuracy 
% Acc, i.e. the differentiation is accurate if the f function is a 
% polynomial of the degree of Acc of less. 
% The actual function being differentiated (i.e. the piecewise 
% polynomial interpolation which is the approximation of the f 
% function) can either be visualized in the figure figure(figr) if figr 
% is a natural number or not if figr == 0. 
% 
%% Variables
% 
% This function has the form of 
% yDeriv = ZDerivativeA(xData, yData, ordDeriv, acc, xDeriv, figr, mode)
% 
% xData and yData are the vectors of the aforementioned values 
% xData(i) and yData(i), respectively, of the independent variable 
% X and of the dependent variable Y, respectively, of an arbitrary 
% function Y = f(X) (yData(i) = f(xData(i)). xData and yData both 
% have to be column vectors of real numbers of equal length. 
% xData vector does not have to be sorted (i.e. it is not required 
% that xData(i) > xData(j) for every i > j). 
% 
% ordDeriv is the order of the differentiation. It has to be an 
% integer contained in the interval [1, length(xData) – Acc]. 
% 
% Acc is the order of accuracy of the differentiation, i.e. the 
% differentiation is accurate if the f function is a polynomial of the 
% degree of Acc of less. It has to be an integer contained in the 
% interval [1, length(xData) – ordDeriv]. 
%
% xDeriv is a vector of values of the independent variable X in 
% which the value of the derivative of the f function is to be 
% calculated. The values of the xDeriv vector do not have to be 
% contained in the [min(xData), max(xData)] interval. 
% 
% figr is the index of the figure in which the actual function being 
% differentiated (i.e. the piecewise polynomial interpolation which 
% is the approximation of the f function) will be visualized. It has 
% to be a nonnegative integer. If figr == 0, the differentiation will 
% not be visualized. 
% 
% mode is the selected mode of differentiation. 
%       If mode == 0, the basic mode of differentiation will be 
%       performed. The derivative in each point xDeriv(i) will be 
%       calculated based on the values of the f function in the 
%       closest Acc + ordDeriv values of the xData vector to the 
%       xDeriv(i). 
%       If mode == 1, an augmented mode of the basic mode of 
%       differentiation will be performed. In this mode, the 
%       derivative in each point xDeriv(i) will be calculated based 
%       on the values of the f function in the closest 
%       Acc + ordDeriv values of the xData vector to the xDeriv(i) 
%       with the constraint that xDeriv(i) has to be both less than 
%       the largest and greater than the smallest of the values of 
%       the Acc + ordDeriv values of the xData vector if possible. 
%       If mode == 2, an augmented mode of the basic mode of 
%       differentiation will be performed. In this mode, the 
%       derivative in each point xDeriv(i) will be calculated based 
%       on the values of the f function in the closest 
%       Acc + ordDeriv values of xData to the xDeriv(i) with the 
%       constraint that no more than 1 + ((Acc + ordDeriv) / 2) 
%       values of xData are to be either larger or smaller than 
%       xDeriv(i) if possible.
%
% yDeriv is the output of the ZDerivativeA function and it is the 
% vector of the values of the derivative of the order of ordDeriv 
% of the f function (F := d^(ordDeriv) f / dX^(ordDeriv)) for the X 
% values of xDeriv (yDeriv(i) = F(xDeriv(i))) calculated with the 
% finite difference method with the order of accuracy Acc.


%     In the following lines, the x and y values are sorted. 

[xData, I] = sort(xData);
yData = yData(I);

%     In the following line, the borders for the intervals I(k) are 
%     calculated. The I(k) intervals are defined as follows: for all 
%     xDeriv(i) values in I(k), the corresponding yDeriv(i) values 
%     are calculated based on the same Acc + ordDeriv pairs of 
%     values (xData(k), yData(k)). The borders of the intervals and 
%     the associated pairs of values depend on the "mode" 
%     parameter. 

npoints = Acc + ordDeriv;

if mode == 0
    [Ipoints, Smatrix] = GetPointsZDerivativeA0(xData, npoints);
else
    if mode == 1
        [Ipoints, Smatrix] = GetPointsZDerivativeA1(xData, npoints);
    else
        if mode == 2
            [Ipoints, Smatrix] = GetPointsZDerivativeA2(xData, npoints);
        end
    end
end

%     In the following lines, the coefficients of the Lagrange 
%     polynomials with which the f function is approximated over 
%     appropriate I(k) intervals as well as the coefficients of the 
%     polynomials which are the derivatives of the Lagrange 
%     polynomials are calculated. 

[pMatrix, pDerivMatrix] = GetLagrangePolynomialMatrix(xData, yData, Smatrix,ordDeriv);

%     In the following lines, if 0 ~= 0, the approximation of the f 
%     function is visualized by the use of the DrawfApproximation 
%     function. 

if figr ~= 0
    DrawfApproximation(xData, yData, Ipoints,  pMatrix, figr, min(xDeriv), max(xDeriv));
end

%     Finally, the intervals in which individual xDeriv(i) points are 
%     located are identified and the numerical differentiation of the 
%     f function is performed in each xDeriv(i) point. 

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

function [Ipoints, Smatrix] = GetPointsZDerivativeA0(x, n)
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

function [Ipoints, Smatrix] = GetPointsZDerivativeA1(x, n)
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
% numerical differentiation is prevented for all possible I(k) 
% intervals. The borders of the augmented I(k) intervals are 
% represented by the vector Ipoints and the S(k) sets are 
% represented by the matrix Smatrix. 
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

[Ipoints, Smatrix] = GetPointsZDerivativeA0(x, n);

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

function [Ipoints, Smatrix] = GetPointsZDerivativeA2(x, n)
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
% S(k). This way, the Lagrange polynomials are differentiated 
% only in such I(k) intervals in which the approximation of the f 
% function may have the greatest fidelity. The borders of the 
% augmented I(k) intervals are represented by the vector Ipoints 
% and the S(k) sets are represented by the matrix Smatrix. 
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

[Ipoints, Smatrix] = GetPointsZDerivativeA0(x, n);

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
%% Lagrange polynomial approximation of the f function 
%% and its derivative polynomial coefficients calculation
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X), this function returns the coefficients of the Lagrange 
% polynomial p and the coefficients of the polynomial which is 
% the ordDeriv-th derivative of the Lagrange polynomial pDeriv. 
% 
%% Variables
% 
% This function has the form of 
% [p, pDeriv] = GetLagrangePolynomial(x, y, ordDeriv)
% 
% x and y are the vectors of the aforementioned values x(i) and 
% y(i), respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors 
% of real numbers of equal length. The x vector needs to be 
% sorted (i.e. it is required that x(i) > x(j) for every i > j). 
% 
% ordDeriv is the order of the derivative of the Lagrange 
% polynomial of points (x(i), y(i)), the coefficients of which will be 
% given in pDeriv. It has to be a natural number. 
% 
% p is the column vector of the coefficients of the Lagrange 
% polynomial of points (x(i), y(i)). The vector p is constructed so 
% that the value of the Lagrange polynomial at the value xx of 
% the variable X is p(1) * power(xx, length(x) - 1) + ... 
% + ... p(1 + m) * power(xx, length(x) - 1 - m) + ... + p(length(x)). 
% 
% pDeriv is the column vector of the coefficients of the 
% polynomial which is the ordDeriv-the derivative of the 
% Lagrange polynomial of points (x(i), y(i)). The vector pDeriv is 
% constructed so that the value of the derivative of the Lagrange 
% polynomial at the value xx of variable X is 
% pDeriv(1) * power(xx, length(x) - ordDeriv - 1) + ... 
% + ... pDeriv(1 + m) * power(xx, length(x) - ordDeriv - 1 - m) + ... 
% + pDeriv(length(x) - ordDeriv).


n = length(x);
A = ones(n, n);

for i = 2 : n
    A(:, i) = power(x, i - 1);
end

a = linsolve(A, y);

p = flipud(a);

%     In the following lines, the coefficients of the Lagrange 
%     polynomial are modified so that they represent the 
%     coefficients of the polynomial which is the ordDeriv-th 
%     derivative of the Lagrange polynomial. 

for i = ordDeriv + 1 : n
    a(i) = a(i) * factorial(i - 1) / factorial(i - 1 - ordDeriv);
end

a = a(ordDeriv + 1 : end);

pDeriv = flipud(a);

end

function [pMatrix, pDerivMatrix] = GetLagrangePolynomialMatrix(xData, yData, Smatrix, ordDeriv)
%% Matrix of the coefficients of the Lagrange polynomials 
%% approximation of the f function and the matrix of the 
%% coefficients of the derivatives of the Lagrange 
%% polynomials calculation
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Given the values xData(i) of the independent variable X and 
% the values yData(i) of the dependent variable Y of an arbitrary 
% function Y = f(X) and the matrix of indices Smatrix, this function 
% returns the matrix pMatrix of coefficients of Lagrange 
% polynomials. Each column of the pMatrix contains the 
% coefficients of the Lagrange polynomial of the values of 
% xData(i) and yData(i) which are represented by the indices of 
% the corresponding row of the Smatrix. 
% Each column of pDerivMatrix contains the coefficients of the 
% polynomial which is the ordDeriv-th derivative of the Lagrange 
% polynomial which is represented by the corresponding column 
% of the pMatrix. 
% 
%% Variables
% 
% This function has the form of 
% [pMatrix, pDerivMatrix] = GetLagrangePolynomialMatrix(xData, yData, Smatrix, ordDeriv)
% 
% xData and yData are the vectors of the aforementioned values 
% xData(i) and yData(i), respectively, of the independent variable 
% X and of the dependent variable Y, respectively, of an arbitrary 
% function Y = f(X) (yData(i) = f(xData(i)). xData and yData both 
% have to be column vectors of real numbers of equal length. 
% xData vector has to be sorted (i.e. it is required that 
% xData(i) > xData(j) for every i > j). 
% 
% Smatrix is a matrix. The values of each row Smatrix(k, :) are 
% indices of the xData(i) and yData(i) values which will be used 
% for the calculation of the coefficients of the Lagrange 
% polynomial which are given in the k-th column of the output 
% matrix pMatrix. 
% 
% ordDeriv is the desired order of the derivative of the Lagrange 
% polynomials.
% 
% pMatrix is the matrix each column pMatrix(:, k) of which 
% contains the coefficients of the Lagrange polynomial based on 
% the values xData(i) and yData(i) which are indexed in the row 
% Smatrix(k, :) of Smatrix (i.e. the Lagrange polynomial is based 
% on the set of pairs of values 
% {(xData(i), yData(i)) | i is contained in Smatrix(k, :)}). 
% Each column pMatrix(:, k) is constructed so that the value of 
% the Lagrange polynomial at the value xx of variable X is 
% pMatrix(1, k) * power(xx, length(Smatrix(:, k)) - 1) + ... 
% + ... pMatrix(1 + m) * power(xx, length(Smatrix(:, k)) - 1 - m) + ... 
% + pMatrix(length(Smatrix(:, k))). 
% 
% pDerivMatrix is the matrix each column pDerivMatrix(:, k) of 
% which contains the coefficients of the polynomial which is the 
% ordDeriv-th derivative of the Lagrange polynomial represented 
% by the column pMatrix(:, k) of pMatrix. Each column 
% pDerivMatrix(:, k) is constructed so that the value of the 
% polynomial at the value xx of variable X is 
% pDerivMatrix(1, k) * 
% power(xx, length(Smatrix(k, :)) - ordDeriv - 1) + ... 
% + ... pDerivMatrix(1 + m, k) * 
% power(xx, length(Smatrix(:, k)) - ordDeriv - 1 - m) + ... 
% + pDerivMatrix(length(Smatrix(k, :)) - ordDeriv, k). 


nIInter = length(Smatrix(:, 1));
npoints = length(Smatrix(1, :));
pMatrix = zeros(npoints, nIInter);
pDerivMatrix = zeros(npoints - ordDeriv, nIInter);

for i = 1 : nIInter
    [pMatrix(:, i), pDerivMatrix(:, i)] = GetLagrangePolynomial(xData(Smatrix(i, :)), yData(Smatrix(i, :)), ordDeriv);
end

end

function DrawfApproximation(x, y, Ipoints,  pMatrix, figr, xmin, xmax)
%% Visualization of the approximation of the function 
%% being differentiated
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Using this function, the visualization of the function fApprox 
% being differentiated by the ZDerivativeA is plotted in the figure 
% figure(figr). fApprox is the approximation of the f function. The 
% input values x(i) of the independent variable X and the values 
% y(i) of the dependent variable Y of the f function Y = f(X) 
% are plotted as blue circles. The fApprox is a piecewise 
% defined function. In each of the X intervals, the fApprox is 
% defined as the Lagrange polynomial of the X interval specific 
% subset of the (x(i), y(i)) pairs of points. 
%
%% Variables
% 
% This function has the form of 
% DrawfApproximation(x, y, Ipoints,  pMatrix, figr, xmin, xmax)
% 
% x and y are the vectors of the aforementioned values x(i) and 
% y(i), respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors 
% of real numbers of equal length. x vector has to be sorted (i.e. 
% it is required that x(i) > x(j) for every i > j). 
% 
% Ipoints is a column vector and pMatrix is a matrix. For each 
% interval [Ipoints(k), Ipoints(k +1)], the plotted approximation of 
% the f function will be the Lagrange polynomial which is based 
% on the set {(x(i), y(i)) | i is in pMatrix(:, k)}. 
% 
% pMatrix is the matrix each column pMatrix(:, k) of which 
% contains the coefficients of the polynomial which is to be 
% plotted over the [Ipoints(k), Ipoints(k +1)] interval. 
% The value of the polynomial with the coefficents of the 
% pMatrix(:, k) column at the value xx of variable X is 
% pMatrix(1, k) * power(xx, length(pMatrix(:, k)) - 1) + ... 
% + ... pMatrix(1 + m, k) * 
% power(xx, length(pMatrix(:, k)) - 1 - m) + ... 
% + pMatrix(length(pMatrix(:, k)), k). 
% 
% figr is the index of the figure in which the differentiation will be 
% visualized. It has to be a positive integer. 
% 
% xmin and xmax are the lower and the upper limit of the X 
% interval [xmin, xmax], respectively. The approximation of the f 
% function will be visualized over the union of the [xmin, xmax] 
% interval and the [min(x), max(x)] interval. 


%     N represents the number of points with which each section 
%     of the approximation of the function will be plotted. 

N = 1000;

figure(figr)
clf;
hold on;

len_Ipoints = length(Ipoints);

% The following lines contain the code for plotting the 
% approximation of the f function either if len_Ipoints ~= 2 or if 
% len_Ipoints == 2 (in the case of which the approximation of the 
% function is the Lagrange polynomial of all (x(i), y(i)) pairs). 

if len_Ipoints ~= 2
    X = (linspace(min(min(x), xmin), Ipoints(2), N))';
    Y = polyval(pMatrix(:, 1), X);
    plot(X, Y, 'r', 'LineWidth', 1.2);
    
    for i = 2 : len_Ipoints - 2
        X = (linspace(Ipoints(i), Ipoints(i + 1), N))';
        Y = polyval(pMatrix(:, i), X);
        plot(X, Y, 'r','LineWidth', 1.2);
    end
            
    X = (linspace(Ipoints(len_Ipoints - 1), max(max(x), xmax), N))';
    Y = polyval(pMatrix(:, end), X);
    plot(X, Y, 'r', 'LineWidth', 1.2);
else
    X = (linspace(min(min(x), xmin), max(max(x), xmax), N))';
    Y = polyval(pMatrix(:, 1), X);
    plot(X, Y, 'r', 'LineWidth', 1.2);
end

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(x, y, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end
