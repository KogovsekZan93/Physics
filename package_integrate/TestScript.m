YY=zeros(9,0);
xmax=16;
Y=-cos(xmax)+xmax+1;
x= (0:xmax/2)'*2;
y=sin(x)+1;
Y=-cos(xmax)+xmax+1;
xmin=0;
figr=0;
for i=1:9
    Psacc=i-1;
    ZInteg1 = ZIntegral1(x,y,xmin,xmax,Psacc,figr);
    YY(i)=(ZInteg1/Y)-1;
end
figure(1);
clf; plot(0:8, YY, 'o');


Psacc=5;
figr=5;
ZInteg1 = ZIntegral1(x,y,xmin,xmax,Psacc,figr);
hold on;
plot(linspace(0,16,100),1+sin(linspace(0,16,100)), 'k');

