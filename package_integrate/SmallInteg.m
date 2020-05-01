function SResul = SmallInteg(x,y,xmin,xmax)
%% Integration of the Lagrange polynomial
% 
% Author: Žan Kogovšek
% Date: 28.4.2020
% 
%% Description
% 
% Given the pairs of values of the independent variable x and the
% dependent variable y of an arbitrary function y = f(x), this 
% function returns the value of the integral of the Lagrange 
% polynomial of the pairs of values with the limits of integration 
% xmin and xmax.
% 
%% Variables
% 
% This function has the form of 
% SResul = SmallInteg(x,y,xmin,xmax).
% 
% x and y are the aforementioned pairs of values of the 
% independent variable x and the dependent variable y 
% (y(i) = f(x(i)). x and y have to be proper vectors (that is in 
% column form).
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration of the Lagrange polynomial p(x) which is based 
% on all pairs of values of x and y (p(x(i)) = y(i) = f(x(i))). 
% 
% SResul is the output of the SmallInteg function and it is the 
% value of the integral of p(x) with the limits of integration xmin  
% and xmax.

%     In the following lines, the coefficients a for the Lagrange 
%     polynomial are found. 

n=length(x);
A=ones(n,n);

for i = 2:n
    A(:,i) = power(x,i - 1);
end

a = linsolve(A,y);

%     In the following lines, the coefficients a are modified so that 
%     they represent the coefficients of the polynomial which is the 
%     integral of the Lagrange polynomial.

for i = 1:n
    a(i) = a(i) / i;
end

a = [0;a];

%     Because coefficients a are in the form 
%     [a0; a1; ... ; an-2; an-1] and the polyval function requires the 
%     reverse order of polynomial coefficients, the values are 
%     flipped. 

p = flipud(a);

SResul=polyval(p,xmax)-polyval(p,xmin);

end

