function DrawZFitA(figr, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix)
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

paramName = 'xFitAMin';
errorMsg = '''xFitAMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitAMax';
errorMsg = '''xFitAMax'' must be a number which is greater than ''xFitAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xFitAMax > xFitAMin, errorMsg);
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

parse(pars, figr, xData, yData, xFitAMin, xFitAMax, Ipoints, Smatrix);


figure(figr)
clf;
hold on;

N = 1000;

xFit = (linspace(xFitAMin, xFitAMax, N))';
yFit = IpointsSmatrixFitValue(xData, yData, xFit, Ipoints, Smatrix);
plot(xFit, yFit, 'r', 'LineWidth', 1.2);

plot(xFit, yFit, 'r', 'LineWidth', 1.2);

plot(xData, yData, 'bo', 'MarkerSize', 10);

set(gca, 'FontSize', 14)
grid on;
hold off;

% The following lines contain the code for plotting the 
% approximation of the f function either if len_Ipoints ~= 2 or if 
% len_Ipoints == 2 (in the case of which the approximation of the 
% function is the Lagrange polynomial of all (x(i), y(i)) pairs). 

end