xData = [0;1;2;3;4;5;6;12;15;16;17;18];
yData = sin(xData) + 1;
number = 4;
[Ipoints, Smatrix] = GetIntervalEndpointsA1(xData, number);
Psacc = number - 1;
mode = 1;
% xEvaluate = [-1;1;0.1;0.2;0.4;1.5;2.2;4.6;8.3;19;20];
xmax= 15;
xmin = 0.5;
xEvaluate = (linspace(xmin,xmax,10000))';
xIntegrate = xEvaluate;
yIntegrate = SmatrixIpointsIntegralValue(xData, yData, xIntegrate, Ipoints, Smatrix);
yEvaluate = SmatrixIpointsFunctionValue(xData, yData, xEvaluate, Ipoints, Smatrix);
figure(1);
clf;
hold on;
plot(xEvaluate, yEvaluate,'b');
plot(xData,yData,'ro');
grid on;

figure(2);
clf;
plot(xIntegrate, yIntegrate,'b');
grid on;
A1=SmatrixIpointsIntegralValue(xData, yData, [xmin;xmax], Ipoints, Smatrix)
A2 = ZIntegralA(xData, yData, xmin, xmax, 'PseudoAccuracy', Psacc, 'Mode', mode, 'Figure', 3)
A1(2) - A2

% tic;SmatrixIpointsIntegralValue(xData, yData, Ipoints, Smatrix, [xmin;xmax]);toc;
% tic;ZIntegralA(xData, yData, xmin, xmax, 'PseudoAccuracy', Psacc, 'Mode', mode);toc;

% p = ConstructPolynomial(xData(Smatrix(1,:)), yData(Smatrix(1,:)));
% plot(xEvaluate,polyval(p,xEvaluate),'b');
% 
% p = ConstructPolynomial(xData(Smatrix(2,:)), yData(Smatrix(2,:)));
% plot(xEvaluate,polyval(p,xEvaluate),'r');