% xData = [0; 1; 2; 3; 6; 10; 11; 12; 14];
% yData = [1; -1; -4; 2; 5; 1; -3; -1; 11];
% figr = 4;
% xIntegralMin = -2;
% xIntegralMax = 13;
% ColorFace = [0, 0, 1];
% nA = 3;
% mode = 2;
% [Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode);
% 
% DrawZIntegralA...
%     (figr, xData, yData, xIntegralMin, xIntegralMax, ...
%     ColorFace, Ipoints, Smatrix);

% area(xData,yData)

xData = [0; 1; 2; 3; 6; 10; 11; 12; 14];
yData = [1; -1; -4; 2; 5; 1; -3; -1; 11];
figr = 4;
xIntegralMin = -2;
xIntegralMax = 13;
ColorFace = [0, 0, 1];
nA = 3;
mode = 2;
ppFitSpline = spline(xData, yData);
[Ipoints, Smatrix] = GetIpointsSmatrix(xData, nA, mode);
PolyDegree = 7;
pFitPolyFit = (polyfit(xData, yData, PolyDegree))';
figure(figr);clf;
DrawZIntegralPolyFit...
    (figr, xData, yData, xIntegralMin, xIntegralMax, ...
    ColorFace, pFitPolyFit)