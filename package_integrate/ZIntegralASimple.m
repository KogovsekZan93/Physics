function ZIntegASimple = ZIntegralASimple(x, y, xmin, xmax)
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
% xmax respectively. The function uses the ZIntegralA function 
% with some predefined values of parameters which seem to be 
% good practice under typical conditions. 
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
% ZIntegASimple is the output of the ZIntegralASimple function 
% and it is the numerical integral of the f function with the limits of 
% integration xmin and xmax. 


%     In the following lines, three parameters of the ZIntegralA 
%     function are set. Consider changing the figr parameter for 
%     visualization. 

Psacc = 3;
mode = 1;
figr = 0;

ZIntegASimple = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr);

end