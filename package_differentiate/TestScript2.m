x=(exp(linspace(-1,1,10)))';
y=exp(x);
xmin=0;
xmax=2;
Psacc=0;
figr=1;
mode=0;
ZIntegA = ZIntegralA(x, y, xmin, xmax, Psacc, figr, mode);
