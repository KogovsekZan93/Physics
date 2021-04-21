xData = [0;1;2;3;4;5;6;12;15;16;17;18];
yData = sin(xData);
[Ipoints, Smatrix] = GetIntervalEndpointsA0(xData, 4);
% xEvaluate = [-1;1;0.1;0.2;0.4;1.5;2.2;4.6;8.3;19;20];
xEvaluate = (linspace(-2,23,10000))';
yEvaluate = IpointsSmatrixFunctionValue(xData, yData, xEvaluate, Ipoints, Smatrix);
figure(1);
clf;
hold on;
plot(xEvaluate, yEvaluate,'b');
plot(xData,yData,'ro');
grid on;

p = ConstructFitPolynomial(xData(Smatrix(1,:)), yData(Smatrix(1,:)));
plot(xEvaluate,polyval(p,xEvaluate),'b');

p = ConstructFitPolynomial(xData(Smatrix(2,:)), yData(Smatrix(2,:)));
plot(xEvaluate,polyval(p,xEvaluate),'r');