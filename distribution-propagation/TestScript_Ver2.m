x=[0;1;2;3];
R = [1, 0.2, 0.1, 0.4; 0.2, 2, 0.3, 0.5; 0.1, 0.3, 3, 1; 0.4, 0.5, 1, 5];
delx=ones(length(x),1)*0.2;
ux=1;
y=[0;3;5;9];
dely=ones(length(y),1)*0.4;
FunTestFunction=@(vec)TestFunction(vec);
VARIABLES={{[x(1),delx(1)],ux},{[x(2),delx(2)],ux},{[x(3),delx(3)],ux},{[x(4),delx(4)],ux},{y, R}};
n=power(10,6);
frepFunTestFunction=ComposedVariable(VARIABLES,FunTestFunction,n);

k=frepFunTestFunction(1,1);
delk=frepFunTestFunction(1,2);
n=frepFunTestFunction(2,1);
deln=frepFunTestFunction(2,2);

figr=3;
figure(figr);
clf;
DrawSimpleLinearRegressionGraph(figr,x,y,k,n,delx,diag(R),delk,deln)