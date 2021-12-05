clear all;
clc;

xData = [0;2;5;6;10;11;11.5];
yData = [0;2;1;4;-2;8;11];
xIntegral = xData;
xFit = xData;
figr = 3;

yIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, xIntegral);

[yFitA, p] = ZFindFit(xData, yData, xFit, 'Type', 'PolyFit', 6, 'Figure', figr);