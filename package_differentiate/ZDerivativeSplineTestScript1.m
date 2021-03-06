clc;
t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
% X = 5*power(t,3)+3*power(t,2)+2*t+1;
% X = power(t,4) - power(t,3) - power(t,2) - t;
% X = power(t,3) - power(t,2) - t;

pp1=spline(t,X);
[breaks,coefs, ~, ~, ~]=unmkpp(pp1);
pp2 = mkpp(breaks,coefs);

tt=(linspace(-5,50,1000))';
XX1=ppval(pp1,tt);
XX2=ppval(pp2,tt);
figure(1);
clf;
hold on;
% plot(tt,XX1, 'ro');
% plot(tt,XX2,'b');
% plot(t,X,'go', 'MarkerSize', 10)
% grid on;


xData=t;
yData=X;
ordDeriv=2;
xDeriv=tt;
figr=2;
yDeriv=ZDerivativeSpline(xData, yData, ordDeriv, xDeriv, figr);

figure(1);
clf;
hold on;
plot(xDeriv, yDeriv, 'r');
yDeriv2 = ZDerivativeASimple(xData, yData, ordDeriv, xDeriv);
plot(xDeriv, yDeriv2, 'b');
grid on;

% plot(xDeriv, 3*power(xDeriv,2) - 2*power(xDeriv,1) - 1 , 'b');
% plot(xDeriv, 4*power(xDeriv,3) - 3*power(xDeriv,3) - 2*power(xDeriv,2) - 1, 'b');
% breaks = [-20 0 1 inf];
% coefs = [-1 0;0 5;1 0];
% pp = mkpp(breaks,coefs);
% clf;
% plot([tt],ppval(pp,[tt]))
% grid on;