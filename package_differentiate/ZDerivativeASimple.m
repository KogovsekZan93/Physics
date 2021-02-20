function yDeriv = ZDerivativeASimple(xData, yData, ordDeriv, xDeriv)
%% Finite difference numerical differentiation with some 
%% predefined values of parameters
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
% the independent variable X. The function uses the 
% ZDerivativeA function with some predefined values of 
% parameters which seem to be good practice under typical 
% conditions. 
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
% xDeriv is a vector of values of the independent variable X in 
% which the value of the derivative of the f function is to be 
% calculated. The values of the xDeriv vector do not have to be 
% contained in the [min(xData), max(xData)] interval. 
% 
% yDeriv is the output of the ZDerivativeASimple function and it 
% is the vector of the values of the derivative of the order of 
% ordDeriv of the f function (F := d^(ordDeriv) f / dX^(ordDeriv)) 
% for the X values of xDeriv (yDeriv(i) = F(xDeriv(i))) calculated 
% with the finite difference method. 


%     In the following lines, three parameters of the ZDerivativeA 
%     function are set. Consider changing the figr parameter for 
%     visualization. 

Acc = 3;
figr = 0;
mode = 1;

yDeriv = ZDerivativeA(xData, yData, ordDeriv, Acc, xDeriv, figr, mode);

end