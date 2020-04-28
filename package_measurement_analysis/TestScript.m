x=[0;1;2;3];
delx=ones(length(x),1)*0.2;
ux=1;
y=[1;3;5;8];
dely=ones(length(y),1)*0.4;
uy=1;
FunTestFunction=@(vec)TestFunction(vec);
VARIABLES={{[x(1),delx(1)],ux},{[x(2),delx(2)],ux},{[x(3),delx(3)],ux},{[x(4),delx(4)],ux},{[y(1),dely(1)],uy},{[y(2),dely(2)],uy},{[y(3),dely(3)],uy},{[y(4),dely(4)],uy}};
n=power(10,6);
frepFunTestFunction=ComposedVariable(VARIABLES,FunTestFunction,n);

k=frepFunTestFunction(1,1);
delk=frepFunTestFunction(1,2);
n=frepFunTestFunction(2,1);
deln=frepFunTestFunction(2,2);

i=3;
figure(i);
clf;
N=power(10,3);
DrawLinearGraph(i,N,x,y,k,n,delx,dely,delk,deln)
