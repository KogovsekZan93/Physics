% clc;
% t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
% X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
% % X = 5*power(t,3)+3*power(t,2)+2*t+1;
% % X = power(t,4) - power(t,3) - power(t,2) - t;
% % X = power(t,3) - power(t,2) - t;
% 
% pp1=spline(t,X);
% [breaks,coefs, ~, ~, ~]=unmkpp(pp1);
% pp2 = mkpp(breaks,coefs);
% 
% tt=(linspace(-5,50,1000))';
% XX1=ppval(pp1,tt);
% XX2=ppval(pp2,tt);
% figure(1);
% clf;
% hold on;
% % plot(tt,XX1, 'ro');
% % plot(tt,XX2,'b');
% % plot(t,X,'go', 'MarkerSize', 10)
% % grid on;
% 
% 
% xData=t;
% yData=X;
% ordDeriv=2;
% xDeriv=tt;
% figr=2;
% yDeriv=ZDerivativeSpline(xData, yData, ordDeriv, xDeriv, figr);
% 
% figure(1);
% clf;
% hold on;
% plot(xDeriv, yDeriv, 'r');
% yDeriv2 = ZDerivativeASimple(xData, yData, ordDeriv, xDeriv);
% plot(xDeriv, yDeriv2, 'b');
% grid on;
% 
% % plot(xDeriv, 3*power(xDeriv,2) - 2*power(xDeriv,1) - 1 , 'b');
% % plot(xDeriv, 4*power(xDeriv,3) - 3*power(xDeriv,3) - 2*power(xDeriv,2) - 1, 'b');
% % breaks = [-20 0 1 inf];
% % coefs = [-1 0;0 5;1 0];
% % pp = mkpp(breaks,coefs);
% % clf;
% % plot([tt],ppval(pp,[tt]))
% % grid on;
% 
% % t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
% % X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
% t = [ 8; 35; 37; 40; 45;0; 1; 3; 5];
% X = [13; 5; 4; 3; 2; 10; 9; 8; 11];
% pp = spline(t, X);
% [breaks, coefs, ~, ~, ~] = unmkpp(pp);
% ppData = mkpp(breaks, coefs);
% coefsLength = length(coefs);
% coefsInteg = [times(coefs, repmat([1/4, 1/3, 1/2, 1], coefsLength, 1)), zeros(coefsLength,1)];

% clc;
% t = [ 8; 35; 37; 40; 45;0; 1; 3; 5];
% X = [13; 5; 4; 3; 2; 10; 9; 8; 11];
% x=t;
% y=X;
% % xmin = 0.5;
% xmin = 34.9;
% % xmax = 9;
% xmax = 40.5;
% figr = 1;
% ZIntegSpl = ZIntegralSpline(x, y, xmin, xmax, figr)
% ZIntegASimple = ZIntegralASimple(x, y, xmin, xmax)

clc;
t = [ 8; 35; 37; 40; 45;0; 1; 3; 5];
X = [13; 5; 4; 3; 2; 10; 9; 8; 11];
x=t;
y=X;
% xmin= 40.5;
% xmax = 10;
xmax= 7;
xmin = 6;
figr = 1;
ZIntegSpl = ZIntegralSpline(x, y, xmin, xmax, 5)
ZIntegASimple = ZIntegralASimple(x, y, xmin, xmax, 2)


