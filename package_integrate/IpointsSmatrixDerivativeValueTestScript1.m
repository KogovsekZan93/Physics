xData = [0;1;2;3;4;5;6;12;15;16;17;18];
yData = sin(xData) + 1;
number = 3;
[Ipoints, Smatrix] = GetIntervalEndpointsA1(xData, number);
mode = 1;
% xEvaluate = [-1;1;0.1;0.2;0.4;1.5;2.2;4.6;8.3;19;20];
xmax= 23;
xmin = -2;
xEvaluate = (linspace(xmin,xmax,1000))';
% xEvaluate = [1;2;3;4;5;6;7;8] + 0.1;
ordDeriv = 1;
xDerivative = xEvaluate;
tic;yDerivative = IpointsSmatrixDerivativeValue(xData, yData, xDerivative, ordDeriv, Ipoints, Smatrix);toc;
yEvaluate = IpointsSmatrixFunctionValue(xData, yData, xEvaluate, Ipoints, Smatrix);
figure(1);
clf;
hold on;
plot(xEvaluate, yEvaluate,'b');
plot(xData,yData,'ro');
grid on;

figure(2);
clf;
plot(xDerivative, yDerivative,'b');
grid on;
yDerivative=IpointsSmatrixDerivativeValue(xData, yData, xDerivative, ordDeriv, Ipoints, Smatrix);
Acc = number - ordDeriv;
xDeriv = xDerivative;
figr = 0;
yDeriv = ZDerivativeA(xData, yData, ordDeriv, Acc, xDeriv, figr, mode);
sum(abs(yDeriv - yDerivative))

% tic;SmatrixIpointsIntegralValue(xData, yData, Ipoints, Smatrix, [xmin;xmax]);toc;
% tic;ZIntegralA(xData, yData, xmin, xmax, 'PseudoAccuracy', Psacc, 'Mode', mode);toc;

% p = ConstructPolynomial(xData(Smatrix(1,:)), yData(Smatrix(1,:)));
% plot(xEvaluate,polyval(p,xEvaluate),'b');
% 
% p = ConstructPolynomial(xData(Smatrix(2,:)), yData(Smatrix(2,:)));
% plot(xEvaluate,polyval(p,xEvaluate),'r');