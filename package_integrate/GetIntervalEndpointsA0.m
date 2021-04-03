function [Ipoints, Smatrix] = GetIntervalEndpointsA0(x, n)
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

Ipoints = zeros(len - n + 2, 1);
Ipoints(1) = - inf;
Ipoints(2 : len - n + 1) = (x(1 : len - n) + x(n + 1 : len)) / 2;
Ipoints(len - n + 2) = inf;

Smatrix = zeros(len - n + 1, n);
for i = 1 : len - n + 1
    Smatrix(i, 1 : n) = (1 : n) + i - 1;
end

end

