function [slope, intercept] = ...
    FindSimpleLinearRegressionCoefficientsFAST...
    (xData, yData)
%% Tool for finding the slope and the intercept of the 
%% simple linear regression curve of the data fast
% 
% Author: Žan Kogovšek
% Date: 10.2.2023
% Last changed: 10.2.2023
% 
%% Description
% 
% Given the input column vectors "xData" of the values 
% "xData"(i)  of the independent variable X and the column 
% vector "yData" of values "yData"(i)  of the dependent variable 
% Y = f(X) = X * a + b, this function returns the estimated values 
% for a ("slope") and b ("intercept") using simple linear 
% regression of the data pairs ("xData"(i), "yData"(i)) without 
% optional input parameters, optional output parameters, or input 
% parsers, which allows for fast calculation. 
% 
%% Variables
% 
% This function has the form of [slope, intercept] = ...
% FindSimpleLinearRegressionCoefficientsFAST(xData, yData)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of the linear function 
% Y = f(X) = X * a + b ("yData" = f("xData")) where the a and the 
% b parameters are to be estimated by this function by using 
% simple linear regression. 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. 
% 
% Both the "slope" parameter and the "intercept" parameter are 
% estimates of the a parameter and b parameter, respectively, 
% calculated by simple linear regression of the data pairs 
% ("xData"(i), "yData"(i)). 


length_xData = length(xData);

H = [xData, ones(length_xData, 1)];
coefficients =H \ yData;

slope = coefficients(1);
intercept = coefficients(2);


end