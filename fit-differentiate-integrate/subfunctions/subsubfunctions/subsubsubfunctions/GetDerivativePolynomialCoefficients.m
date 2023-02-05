function pDerivativeA = GetDerivativePolynomialCoefficients...
    (xData, yData, ordDeriv)
%% Tool for obtaining the coefficients of the polynomial 
%% which is the derivative of the interpolation polynomial 
%% of the input data
% 
% Author: Žan Kogovšek
% Date: 2.5.2023
% Last changed: 2.5.2023
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = f(X) 
% ("yData" = f("xData")), this function returns the vector 
% "pDerivativeA" of the coefficients of the polynomial which is 
% the "ordDeriv"-th order derivative of the interpolation 
% polynomial of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). 
% 
%% Variables
% 
% This function has the form of pDerivativeA = ...
% GetDerivativePolynomialCoefficients(xData, yData, ordDeriv)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = f(X) 
% ("yData" = f("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "OrdDeriv" is the parameter which is the derivative order. It 
% must be a natural number. 
% 
% "pDerivativeA" is the vector of coefficients of the polynomial 
% which is the "OrdDeriv"-th order derivative of the interpolation 
% polynomial of the data points represented by the pairs 
% ("xData"(i), "yData"(i)). The "pDerivativeA" vector is a column 
% vector of the form of 
% [a_(length("xData") - "OrdDeriv" - 1); ...
% a_(length("xData") - "OrdDeriv" - 2); ...; a_1; a_0]. The 
% polynomial can be evaluated by the MATLAB polyval function. 


pDerivativeA = CalculateDerivativePolynomialCoefficients...
    (GetFitPolynomialCoefficients(xData, yData), ordDeriv);

end