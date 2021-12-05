clear all;
clc;

xData = [0;2;5;6;10;11;11.5];
yData = [0;2;1;4;-2;8;11];
xIntegral = xData;
xFit = xData;
xDerivative = xData;
figr = 3;

yIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, xIntegral);

[yFitA, p] = ZFindFit(xData, yData, xFit, 'Type', 'PolyFit', 6);

[yDerivative, ppDerivativeSpline]  = ZFindDerivative(xData, yData, xDerivative, 'Type', 'PolyFit', 3, 'OrdDeriv', 2, 'Figure', 0);

DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, [0;10], 'Type', 'Spline', 'Figure', figr)