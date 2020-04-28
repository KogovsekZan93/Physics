x=[-3;-2;3;4;5;8];
y=sin(x);
xmin=-2;
xmax=4;
n=3;

figr=1;
Integ = InterInteg(x,y,xmin,xmax,n,figr);
hold on;
plot(linspace(-3,8,100),sin(linspace(-3,8,100)), 'k');
