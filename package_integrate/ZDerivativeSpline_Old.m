function yDeriv = ZDerivativeSpline_Old(xData, yData, ordDeriv, xDeriv, figr)
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


%     In the following line, the borders for the intervals I(k) are 
%     calculated. The I(k) intervals are defined as follows: for all 
%     xDeriv(i) values in I(k), the corresponding yDeriv(i) values 
%     are calculated based on the same Acc + ordDeriv pairs of 
%     values (xData(k), yData(k)). The borders of the intervals and 
%     the associated pairs of values depend on the "mode" 
%     parameter. 

pp = spline(xData, yData);
[breaks, coefs, ~, ~, ~] = unmkpp(pp);
ppData = mkpp(breaks, coefs);

coefsDeriv = coefs;

if ordDeriv < 4
    for i = 1 : ordDeriv
        ordPoly = length(coefsDeriv(1, :)) - 1;
        coefsDeriv = times(coefsDeriv(:, 1 : ordPoly), repmat((ordPoly : -1 : 1), length(coefsDeriv(:,1)), 1));
    end
else
     coefsDeriv=zeros(length(coefsDeriv(:,1)),1);
end

ppDeriv = mkpp(breaks, coefsDeriv);

if figr ~= 0
    DrawfApproximation(xData, yData, ppData, figr, min(min(xDeriv), min(xData)), max(max(xDeriv), max(xData)));
end

yDeriv = ppval(ppDeriv, xDeriv);

end

function DrawfApproximation(xData, yData, ppData, figr, xmin, xmax)
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

% The following lines contain the code for plotting the 
% approximation of the f function either if len_Ipoints ~= 2 or if 
% len_Ipoints == 2 (in the case of which the approximation of the 
% function is the Lagrange polynomial of all (x(i), y(i)) pairs). 

X = (linspace(xmin, xmax, N))';
Y = ppval(ppData, X);
plot(X, Y, 'r', 'LineWidth', 1.2);

%     In the following line, the input pairs of values (x(i), y(i)) are 
%     plotted.

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

end