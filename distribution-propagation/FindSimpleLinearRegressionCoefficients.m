function [slope, intercept] = ...
    FindSimpleLinearRegressionCoefficients(xData, yData)

length_xData = length(xData);

A = [xData, ones(length_xData, 1)];
coefficients=A \ yData;
slope = coefficients(1);
intercept = coefficients(2);

end