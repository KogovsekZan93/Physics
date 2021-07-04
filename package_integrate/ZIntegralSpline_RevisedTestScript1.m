% pp=mkpp([1,-100],[1,0,0]);
% ppval(pp,3)

xData = [0;1;2;3;4;5;6;12;15;16;17;18];
yData = sin(xData) + 1;
xmin = 3;
xmax = 13;
xIntegralSpline =[xmin; xmax];
ZIntegSpl_Revized = ZIndefiniteIntegralSpline(xData, yData, xIntegralSpline, 'Figure', 2);
ZIntegSpl = ZIntegralSpline(xData, yData, xmin, xmax, 1);
Limits = [xmin; xmax+4];
ZDefIntegSpline = ZDefiniteIntegralSpline(xData, yData, Limits, 'Figure', 3)