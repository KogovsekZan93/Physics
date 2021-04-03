function [Ipoints, Smatrix] = GetIntervalEndpointsA1(x, n)
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

[Ipoints, Smatrix] = GetIntervalEndpointsA0(x, n);

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