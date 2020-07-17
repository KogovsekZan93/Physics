YY=zeros(9,0);
xmax=16;
Y=-cos(xmax)+xmax+1;
x= (0:xmax/2)'*2;
y=sin(x)+1;
xmin=0;
figr=0;
% for i=1:9
%     Psacc=i-1;
%     ZInteg1 = ZIntegral1(x,y,xmin,xmax,Psacc,figr);
%     YY(i)=(ZInteg1/Y)-1;
% end
% figure(1);
% clf; plot(0:8, YY, 'o');

mode = 2;
Psacc=3;
figr=3;
ZInteg1 = ZIntegralA(x,y,xmin,xmax,Psacc,figr,mode);
hold on;
plot(linspace(0,16,100),1+sin(linspace(0,16,100)), 'k');

% x=[-3;-2;3;4;5;8];
% y=sin(x);
% xmin=-2;
% xmax=4;
% Psacc=2;
% mode=0;
% 
% figr=1;
% Integ = ZIntegralA(x,y,xmin,xmax,Psacc,figr,mode);
% hold on;
% plot(linspace(-3,8,100),sin(linspace(-3,8,100)), 'k');


% x=[0;1;3;5;8;35;37;40;45];
% y=[10;9;8;11;13;5;4;3;2];
% 
% xmax=45;
% xmin=0;
% Psacc=0;
% figr=3;
% mode=0;
% ZIntegA = ZIntegralA(x,y,xmin,xmax,Psacc,figr,mode);


