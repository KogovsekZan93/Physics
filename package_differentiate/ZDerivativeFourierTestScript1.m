% clc;
% t = [0; 1; 2; 3; 4; 5; 6; 7; 8];
% X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
% 
% pp1=spline(t,X);
% [breaks,coefs, ~, ~, ~]=unmkpp(pp1);
% pp2 = mkpp(breaks,coefs);
% 
% tt=(linspace(-1,9,1000))';
% 
% xData=t;
% yData=X;
% ordDeriv=1;
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
% yDeriv3 = ZDerivativeFourier(xData, yData, ordDeriv, figr);
% plot(xData, yDeriv3, 'go');
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

% % % % % % % % % x = [0;0.4;0.8;1.2;1.6;2.0;2.4;2.8;3.2;3.6;4.0;4.4;4.8;5.2];
% % % % % % % % % x = [x;x+5.6];
% % % % % % % % % x = [x;x+max(x)+0.4];
% % % % % % % % % x=x(1:end-1);
% % % % % % % % % % y=power(x,2)/2;
% % % % % % % % % y=sin(x);
% % % % % % % % % figure(1);clf;
% % % % % % % % % plot(x,y,'bo');grid on;
% % % % % % % % % Y = fft(y);
% % % % % % % % % figure(2);clf;
% % % % % % % % % plot(x,abs(Y),'bo');grid on;
% % % % % % % % % n=length(x);
% ftdiff = (-2*pi*1i/n)*(0:n/2-1)';
% ftdiff = [ftdiff;(flipud(ftdiff))];
% nx = length(x);
% hx = ceil(nx/2)-1;
% ftdiff = ((2i*pi/nx)*(0:hx))';
% ftdiff(nx:-1:nx-hx+1) = -ftdiff(2:hx+1);
% YDeriv = Y.*ftdiff;
% yDeriv = ifft(YDeriv)/0.4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N=length(x);
% L = max(x)-min(x);
% Y = fft(y)
% nx = length(x);
% hx = ceil(nx/2)-1;
% ftdiff = (0:hx)';
% ftdiff(nx:-1:nx-hx+1) = -ftdiff(2:hx+1)
% M = [0:(N/2-1) 0 (1-N/2):(-1)]';
% k = 2*pi*M/L;
% yDeriv = real(ifft(1i*k.*Y))
% figure(3);clf;
% plot(x,yDeriv,'bo');grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = [0;0.4;0.8;1.2;1.6;2.0;2.4;2.8;3.2;3.6;4.0;4.4;4.8;5.2];
x = [x;x+5.6];
x = [x;x+max(x)+0.4;max(x)+0.8];
x=x(1:end-1);
% y=power(x,2)/2;
y=sin(x);
figure(1);clf;
plot(x,y,'bo');grid on;
Y = fft(y);
figure(2);clf;
plot(x,abs(Y),'bo');grid on;
n=length(x);
N=length(x);
L = max(x)-min(x);
Y = fft(y)
N = length(x);
% hx = ceil(N/2)-1;
% M = (0:hx)';
% M(N:-1:N-hx+1) = -M(2:hx+1);
M = (0:N-1)';
M(ceil(N/2) + 1:end) = M(ceil(N/2)+1:end) - N

k = 2*pi*M/L;
yDeriv = real(ifft(1i*k.*Y))
yDerivDeriv = real(ifft((1i*k.*Y).*k*1i));
figure(3);clf;
plot(x,yDerivDeriv,'bo');grid on;

