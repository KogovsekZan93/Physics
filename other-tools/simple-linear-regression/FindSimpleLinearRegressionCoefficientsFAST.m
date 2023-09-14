function [slope, intercept] = ...
    FindSimpleLinearRegressionCoefficientsFAST...
    (xData, yData)

length_xData = length(xData);

H = [xData, ones(length_xData, 1)];
coefficients =H \ yData;

slope = coefficients(1);
intercept = coefficients(2);


end