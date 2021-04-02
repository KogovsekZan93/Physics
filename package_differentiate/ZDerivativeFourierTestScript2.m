x = [0;0.4;0.8;1.2;1.6;2.0;2.4;2.8;3.2;3.6;4.0;4.4;4.8;5.2];
x = [x;x+5.6];
x = [x;x+max(x)+0.4;max(x)+0.8];
x=x(1:4);
% y=power(x,2)/2;
y=sin(x);
% y=power(x-max(x/2),2);
figure(1);clf;
plot(x,y,'bo');grid on;
Y = fft(y);
figure(2);clf;
plot(x,abs(Y),'bo');grid on;

xData=x;
yData=y;
ordDeriv = 1;
yDeriv = ZDerivativeFourier(xData, yData, ordDeriv);
figure(3);clf;
plot(x,yDeriv,'bo');grid on;
figure(4);
NN=1000;
yFu = interpft(y,NN);
clf;
hold on;
plot(x,y,'bo');
plot(linspace(min(x), max(x), NN),yFu,'r');
grid on;

