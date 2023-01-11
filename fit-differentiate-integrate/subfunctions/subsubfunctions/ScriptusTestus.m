xData = [0;1;2;3;4;5;6;7;8;9];
xData = power(xData,4);
yData = xData;
plot(xData,yData,'ro');grid on;
xIntegralSpline = (linspace(-2,6561.5,10))';
% xIntegralSpline = xData;
% xIntegralSpline = [-1;2;400; 410];
[yIntegralSpline] = ZFindIntegralSplineBasic...
    (xData, yData, xIntegralSpline);
((power(xIntegralSpline,2)-power(xIntegralSpline(1),2))/2)-yIntegralSpline