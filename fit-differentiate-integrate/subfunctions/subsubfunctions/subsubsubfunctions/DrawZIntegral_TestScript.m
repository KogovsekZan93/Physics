xData = [0; 1; 2; 3; 6; 10; 11; 12; 14];
yData = [1; -1; -4; 2; 5; 1; -3; -1; 11];
figr = 4;
xIntegralMin = -2;
xIntegralMax = 5;
ColorFace = [0, 0, 1];
ppFitSpline = spline(xData, yData);

DrawZIntegralSpline...
    (figr, xData, yData, xIntegralMin, xIntegralMax, ...
    ColorFace, ppFitSpline)

area(xData,yData)